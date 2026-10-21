# Build upload archives from the canonical skill without installing or publishing.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$utf8 = [System.Text.UTF8Encoding]::new($false)
$portable = Get-Content -Raw -LiteralPath (Join-Path $repositoryRoot 'plugin.json') | ConvertFrom-Json
$claude = Get-Content -Raw -LiteralPath (Join-Path $repositoryRoot '.claude-plugin/plugin.json') | ConvertFrom-Json
$package = Get-Content -Raw -LiteralPath (Join-Path $repositoryRoot 'package.json') | ConvertFrom-Json
$skillFile = Join-Path $repositoryRoot 'skills/whid/SKILL.md'
$skill = Get-Content -Raw -LiteralPath $skillFile
$version = [regex]::Match($skill, '(?m)^  version: "([^"]+)"').Groups[1].Value
if (!$version -or $portable.version -ne $version -or $claude.version -ne $version -or $package.version -ne $version) {
    throw 'Skill, package, and both plugin manifest versions must match.'
}
foreach ($field in @('name', 'description', 'homepage', 'repository', 'license')) {
    if ($portable.$field -ne $claude.$field) { throw "Plugin identity mismatch: $field" }
}
& node (Join-Path $PSScriptRoot 'validate-repository.mjs')
if ($LASTEXITCODE -ne 0) { throw 'Repository validation failed.' }

$outputDirectory = Join-Path $repositoryRoot "dist/$version"
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null

# Explicit allowlist: no Git metadata, source fixtures, local reports, or credentials.
$skillFiles = @('skills/whid/SKILL.md') + @(
    Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'skills/whid/references') -File -Filter '*.md' |
        Sort-Object Name | ForEach-Object { "skills/whid/references/$($_.Name)" }
)
$commonFiles = @('LICENSE', 'NOTICE', 'PRIVACY.md') + $skillFiles
$archives = [ordered]@{}
foreach ($target in @('codex', 'claude', 'agensi')) {
    $entries = [ordered]@{}
    foreach ($file in $commonFiles) {
        $entryName = if ($target -eq 'agensi') { $file -replace '^skills/whid/', '' } else { $file }
        $entries[$entryName] = Join-Path $repositoryRoot $file
    }
    if ($target -ne 'agensi') {
        $entries['README.md'] = Join-Path $repositoryRoot 'packaging/README.md'
        $entries['assets/whid.svg'] = Join-Path $repositoryRoot 'assets/whid.svg'
        $manifestPath = if ($target -eq 'codex') { 'plugin.json' } else { '.claude-plugin/plugin.json' }
        $entries[$manifestPath] = Join-Path $repositoryRoot $manifestPath
    }
    $archivePath = Join-Path $outputDirectory "whid-$version-$target.zip"
    $stream = [System.IO.File]::Open($archivePath, [System.IO.FileMode]::Create)
    $zip = [System.IO.Compression.ZipArchive]::new($stream, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        foreach ($entryName in ($entries.Keys | Sort-Object)) {
            $source = Get-Item -LiteralPath $entries[$entryName]
            if ($source.Attributes -band [System.IO.FileAttributes]::ReparsePoint) { throw "Symlink rejected: $source" }
            $entry = $zip.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
            $entry.LastWriteTime = [DateTimeOffset]::new(1980, 1, 1, 0, 0, 0, [TimeSpan]::Zero)
            $entryStream = $entry.Open()
            try {
                $bytes = [System.IO.File]::ReadAllBytes($source.FullName)
                $entryStream.Write($bytes, 0, $bytes.Length)
            } finally { $entryStream.Dispose() }
        }
    } finally { $zip.Dispose(); $stream.Dispose() }

    # Verify every packaged byte against its source, including hidden manifests.
    $stream = [System.IO.File]::OpenRead($archivePath)
    $zip = [System.IO.Compression.ZipArchive]::new($stream, [System.IO.Compression.ZipArchiveMode]::Read)
    try {
        if ($zip.Entries.Count -ne $entries.Count) { throw 'Unexpected archive entry count.' }
        foreach ($entry in $zip.Entries) {
            if (!$entries.Contains($entry.FullName)) { throw "Unexpected archive entry: $($entry.FullName)" }
            $buffer = [System.IO.MemoryStream]::new()
            $entryStream = $entry.Open()
            try {
                $entryStream.CopyTo($buffer)
                $actual = [Convert]::ToBase64String($buffer.ToArray())
                $expected = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($entries[$entry.FullName]))
                if ($actual -cne $expected) { throw "Archive content mismatch: $($entry.FullName)" }
            } finally { $entryStream.Dispose(); $buffer.Dispose() }
        }
    } finally { $zip.Dispose(); $stream.Dispose() }
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    try {
        $hash = [BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($archivePath))).Replace('-', '').ToLowerInvariant()
    } finally { $sha256.Dispose() }
    $archives[$target] = [ordered]@{
        file = [System.IO.Path]::GetFileName($archivePath)
        sha256 = $hash
        entries = @($entries.Keys | Sort-Object)
    }
    Write-Output "Verified $archivePath ($($entries.Count) files)"
}
$sourceCommit = & git -C $repositoryRoot rev-parse HEAD
if ($LASTEXITCODE -ne 0) { throw 'Cannot determine source commit.' }
$sourceStatus = @(& git -C $repositoryRoot status --porcelain)
if ($LASTEXITCODE -ne 0) { throw 'Cannot determine source status.' }
$metadata = [ordered]@{
    version = $version
    repository = $portable.repository
    sourceCommit = $sourceCommit
    sourceDirty = ($sourceStatus.Count -gt 0)
    price = 'Free'
    archives = $archives
}
[System.IO.File]::WriteAllText((Join-Path $outputDirectory 'build-info.json'), ($metadata | ConvertTo-Json -Depth 8) + "`n", $utf8)
$sums = @($archives.Values | ForEach-Object { "$($_.sha256)  $($_.file)" }) -join "`n"
[System.IO.File]::WriteAllText((Join-Path $outputDirectory 'SHA256SUMS.txt'), $sums + "`n", $utf8)
$listing = @"
Name: WhatHaveIDone (WHID)
Version: $version (prerelease)
Price: Free
License: Apache-2.0
Repository: $($portable.repository)
Support: $($portable.repository)/issues
Publisher: $($portable.author.name)
Short description: $($portable.extensions.'com.openai'.interface.shortDescription)

$($portable.extensions.'com.openai'.interface.longDescription)

Tags: $($portable.keywords -join ', ')
Requirements: Git, repository access, and a capable coding agent. Host AI costs apply.
Claude source: hasan-gundogdu/WhatHaveIDone; plugin path: repository root.
Publication state: Prepared locally; not submitted or published by this script.
"@
[System.IO.File]::WriteAllText((Join-Path $outputDirectory 'listing.txt'), $listing + "`n", $utf8)
