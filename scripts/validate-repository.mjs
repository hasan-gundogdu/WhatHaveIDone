import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repositoryRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const skillRoot = path.join(repositoryRoot, "skills", "whid");
const skillFile = path.join(skillRoot, "SKILL.md");
const packageFile = path.join(repositoryRoot, "package.json");
const errors = [];
let skillVersion;

function fail(message) {
  errors.push(message);
}

function relative(file) {
  return path.relative(repositoryRoot, file).split(path.sep).join("/");
}

function markdownFiles(directory) {
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const target = path.join(directory, entry.name);
    if (entry.isDirectory() && ![".git", "node_modules"].includes(entry.name)) {
      return markdownFiles(target);
    }
    return entry.isFile() && entry.name.endsWith(".md") ? [target] : [];
  });
}

if (!fs.existsSync(skillFile)) {
  fail("skills/whid/SKILL.md is missing");
} else {
  const skill = fs.readFileSync(skillFile, "utf8");
  const lines = skill.split(/\r?\n/).length;
  const frontmatter = skill.match(/^---\r?\n([\s\S]*?)\r?\n---/);

  if (!frontmatter) {
    fail("SKILL.md has no valid YAML frontmatter boundary");
  } else {
    const name = frontmatter[1].match(/^name:\s*([^\r\n]+)$/m)?.[1]?.trim();
    if (name !== path.basename(skillRoot)) {
      fail(`frontmatter name '${name ?? "missing"}' does not match folder 'whid'`);
    }

    skillVersion = frontmatter[1]
      .match(/^\s{2}version:\s*["']?([^"'\r\n]+)["']?\s*$/m)?.[1]?.trim();
    if (!skillVersion) {
      fail("SKILL.md frontmatter metadata.version is missing");
    } else if (!/^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$/.test(skillVersion)) {
      fail(`SKILL.md metadata.version '${skillVersion}' is not a supported semantic version`);
    }
  }

  if (lines > 500) {
    fail(`SKILL.md has ${lines} lines; maximum is 500`);
  }
  if (skill.length > 20_000) {
    fail(`SKILL.md has ${skill.length} characters; exceeds the approximate 5,000-token budget`);
  }

  const forbiddenCorePatterns = [
    [/agents\/openai\.yaml/i, "agents/openai.yaml"],
    [/allowed-tools/i, "allowed-tools"],
    [/\bCodex\b/i, "Codex-specific behavior"],
    [/\bClaude(?: Code)?\b/i, "Claude-specific behavior"],
    [/[A-Za-z]:\\/, "Windows-style absolute path"],
  ];
  for (const [pattern, label] of forbiddenCorePatterns) {
    if (pattern.test(skill)) fail(`SKILL.md contains prohibited ${label}`);
  }

  const directReferenceLinks = new Set(
    [...skill.matchAll(/\]\((references\/[^)#]+\.md)(?:#[^)]+)?\)/g)].map((match) => match[1]),
  );
  const referenceDirectory = path.join(skillRoot, "references");
  for (const entry of fs.readdirSync(referenceDirectory, { withFileTypes: true })) {
    if (entry.isFile() && entry.name.endsWith(".md")) {
      const expected = `references/${entry.name}`;
      if (!directReferenceLinks.has(expected)) {
        fail(`${expected} is not linked directly from SKILL.md`);
      }
      const content = fs.readFileSync(path.join(referenceDirectory, entry.name), "utf8");
      if (/\]\((?:\.\.\/)?references\//.test(content)) {
        fail(`${expected} creates a nested reference chain`);
      }
      if (/[A-Za-z]:\\/.test(content)) {
        fail(`${expected} contains a Windows-style absolute path`);
      }
      if (/\b(?:Codex|Claude(?: Code)?)\b/i.test(content)) {
        fail(`${expected} contains host-specific behavior`);
      }
    }
  }
}

if (!fs.existsSync(packageFile)) {
  fail("package.json is missing");
} else {
  const packageVersion = JSON.parse(fs.readFileSync(packageFile, "utf8")).version;
  if (skillVersion && packageVersion !== skillVersion) {
    fail(`package.json version '${packageVersion}' does not match skill version '${skillVersion}'`);
  }
}

for (const file of markdownFiles(repositoryRoot)) {
  const content = fs.readFileSync(file, "utf8");
  for (const match of content.matchAll(/\[[^\]]+\]\(([^)]+)\)/g)) {
    const rawTarget = match[1].trim().replace(/^<|>$/g, "");
    const target = rawTarget.split("#", 1)[0];
    if (!target || /^(?:https?:|mailto:)/i.test(target) || path.isAbsolute(target)) continue;
    const resolved = path.resolve(path.dirname(file), decodeURIComponent(target));
    if (!fs.existsSync(resolved)) {
      fail(`${relative(file)} has a broken relative link: ${rawTarget}`);
    }
  }
}

for (const forbidden of [
  path.join(skillRoot, "agents", "openai.yaml"),
  path.join(skillRoot, "hooks"),
  path.join(skillRoot, "scripts"),
  path.join(skillRoot, "assets"),
]) {
  if (fs.existsSync(forbidden)) fail(`${relative(forbidden)} is outside the Core v0.1 boundary`);
}

if (errors.length) {
  console.error("WHID repository validation failed:");
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

console.log("WHID repository validation passed.");
