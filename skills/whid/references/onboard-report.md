# Onboard Report Contract

Teach a developer how the current project works well enough to trace a real
operation and locate a small change. Build a coherent reading route from purpose
to execution to development practice. Breadth means covering the discovered
system boundaries and important flows, not explaining every file.

## Establish the project and learning route

1. Resolve the Git root and current HEAD (or record an unborn repository).
   Inventory the current working tree, including relevant untracked files, and
   disclose local modifications. Explain current on-disk behavior; staged-only
   versions are not a second runtime to teach. No checkout or Git mutation.
2. Read applicable repository instructions, documentation indexes, README,
   architecture/domain documents, and ADRs where present. Use them to guide
   targeted code exploration. Existing documentation is evidence of intent;
   validate important behavior against code, composition, configuration, and tests.
3. Map applications/modules, entry points, boundaries, major user operations,
   external dependencies, and development commands. Adapt to the repository:
   a library, CLI, or instruction-only skill need not have HTTP or a database.
   Mark inaccessible services and other repositories as unexplored boundaries.
4. Present the ordered outline before drafting chapters. Give each chapter a
   learning goal and its prerequisite chapters. Normally continue without asking
   for outline approval. On large projects, distinguish the core route from
   optional module deep dives; honor any user-provided focus or cost/time limit.
5. Follow the route in prerequisite order. Finish a chapter with evidence before
   moving to one that depends on it. Use stable chapter IDs and filenames so
   future updates preserve navigation. Replan when evidence changes the map.

For saved runs, reconcile existing state before presenting the updated outline
and drafting chapters. For chat-only runs, use the same teaching contract but
do not create files or promise durable resume state.

## Suggested teaching order

Adapt this sequence to the actual project; omit unsupported topics and add
necessary prerequisites. An outline is a learning plan, not a mandatory seven
chapter template.

1. **Purpose and domain:** users, outcomes, vocabulary, important rules.
2. **System map:** applications/modules, responsibilities, dependency direction,
   runtime composition, and external boundaries.
3. **Primary end-to-end flow:** one representative real operation from input
   through decisions and state/data changes to output. Trace concrete symbols.
4. **Connected flows:** important alternatives, failures, background work,
   integrations, and authorization/data isolation where actually applicable.
5. **Decisions and constraints:** documented reasons, tradeoffs, invariants,
   and implementation/documentation disagreements. Unknown reasons stay UNKNOWN.
6. **Working as a developer:** evidenced setup/run/test commands, configuration
   names without secret values, and where a representative small change belongs.
   Explain commands without executing them. Distinguish documented from verified.
7. **Practice and recall:** a small code-navigation exercise and questions that
   require explaining this project's behavior, tradeoffs, or change impact.

Introduce a term before relying on it; link back when it recurs. Adapt technical
depth to the user's explicitly stated expertise and learning goals. Explain
new concepts only where they are needed to trace this project's behavior; do
not pad experienced-developer routes with introductory tutorials. For a key
operation, link the trigger, decisions, data/state changes and observable result
through concrete code evidence. Keep documented intent separate from confirmed
implementation and technical evaluation. A short recap should connect each
chapter to the previous one and the next step. Use diagrams
only when they clarify a real flow. Portable Markdown is the canonical output;
Mermaid or plain-text diagrams may supplement prose. HTML is outside this mode.

## Chapter contract

Each substantive chapter should provide:

- a learning goal and prerequisite links
- a connected explanation of behavior, responsibilities, and relevant rules
- a concrete code/operation walkthrough when the topic warrants it
- short concept reminders attached to actual code decisions
- material claims mapped to compact evidence: repository-relative path, symbol,
  snapshot/revision, strength, and limits; cite authoritative docs instead of
  copying them into a competing manual
- a contextual understanding question or navigation exercise with an answer
  hint/evidence pointer; use only as many as the chapter can support
- previous/next navigation in saved output, consistent with the index

Preserve CONFIRMED, INFERRED, and UNKNOWN. A saved chapter is a generated teaching
aid, not an authoritative architecture record or independent source of truth.
It cannot substantiate its own claims. Avoid generic language tutorials and
package-list descriptions of architecture. Do not invent intentions or fill
evidence gaps just to complete the outline.

## Entry point and coverage

The guide title is followed by the exact active `WHID Core version`. In saved
guides this belongs in `index.md`; each chapter identifies the snapshot used and
its freshness. The index includes:

- project scope, HEAD if available, local-change disclosure, and report language
- an ordered reading route with learning goals and chapter status
- the system areas/flows covered, optional deep dives deferred, and exclusions
- documentation/code discrepancies and unresolved evidence gaps
- test execution status and whether setup/run commands were actually verified
- on refresh: which chapters were reused, revised, added, blocked, or still pending

Be explicit about scope: a core-route guide is not proof that every subsystem
was inspected. A chapter may be complete with honestly labeled unknowns; it may
not be complete with a promised walkthrough missing. Distinguish an evidence
gap from unfinished work. If a user limit or interruption prevents completion,
deliver a clearly partial guide with the next pending chapter, not an empty
outline presented as the final result. Otherwise continue through the agreed route.

## Completion checks

- The explanation starts with domain/purpose and connects to actual execution.
- Every planned core chapter is complete, or the guide explicitly says partial.
- At least one representative operation is traced across the available local
  boundaries; missing external links are disclosed rather than invented.
- The reader can find the relevant code for a plausible small change.
- Important claims have evidence, and reported coverage matches inspected scope.
- Ordering, prerequisites, and links form a coherent route with no cycles.
- Test/setup execution statements are accurate.
- Saved state has passed the state contract before any chapter is called current.
