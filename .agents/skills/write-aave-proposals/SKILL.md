---
name: write-aave-proposals
description: Use automatically when creating, implementing, testing, documenting, or reviewing an Aave governance proposal. Do not use for work on the proposal generator or its features. Surface specification, execution, interface, testing, documentation, and multichain-dispatch knowledge while leaving material choices to the writer.
---

# Write Aave Proposals

Apply only the guidance relevant to the current task. Surface hidden tradeoffs and recommendations; do not silently make material choices.

## Reconcile scope

- Compare the forum, deployments, config, payloads, tests, and Markdown; surface every mismatch.
- Check every address-book address against addresses explicitly named in the forum. If they differ, identify the correct target and tell the user to coordinate a forum amendment before syncing code and Markdown.
- For multichain scope, list active chains separately from relevant deprecated, legacy, or partial deployments, including module availability and consequences, then ask which to include.

## Choose execution shape

- One payload ID with multiple actions is ordered and atomic; prefer it for dependent actions.
- Multiple payload IDs in one governance proposal are failure-isolated but not ordered; prefer them for independent modules.
- Separate governance proposals also separate voting and scheduling.
- Recommend based on dependency and failure isolation, then ask when no choice was given.

## Reuse contract surfaces

- Address-book interfaces take priority; update the canonical interface when a method is missing instead of shadowing it locally.
- For Aave-infrastructure contracts, add missing entries to `aave-address-book`, then propagate the revision through `aave-helpers` before using it here.
- If the address book has no interface, a minimal local interface containing only required methods is fine.
- Do not add a dependency solely to obtain an interface.
- Prefer typed entries and runtime getters over recasting and hardcoded role hashes.
- Before deploying a contract in `execute`, surface whether it is one-off or likely reusable. Keep one-offs local; recommend predeploying, verifying, and registering recurring components.

## Keep implementation focused

- Keep NatSpec and inline comments to intent and non-obvious invariants; keep proposal narrative in Markdown.

## Test behavior

- For each material change, propose an exact pre-state assertion, one execution, and a post-state assertion.
- When rewriting a configuration, identify untouched fields at risk and test selected unchanged fields.
- Inspect generated diffs and events; flag missing instrumentation instead of treating an absent diff as proof of no change.

## Write Markdown

- Use the current generator skeleton and References format; regenerate instead of handcrafting the layout.
- Fetch the Discourse topic through its `.json` URL, save the post content, and mechanically diff it with the Markdown after normalizing only generator-imposed structure and explicit Disclaimer removal. Content differences are not acceptable.
- Keep generated repository links on `main` before merge so the IPFS workflow can pin the final commit.
- Diff against both the generator skeleton and saved forum content, accounting for every difference.

## Validate large cross-chain dispatches

- Simulate the complete Ethereum `executeProposal` from cold state using real Governance, CrossChainController, and configured adapters rather than per-payload mocks.
- Report gas against current constraints, `PayloadSent` count, adapter attempts, and successful destinations, distinguishing attempts from chains.
- If results or margin are concerning, present splitting options and ask before changing the execution shape.
