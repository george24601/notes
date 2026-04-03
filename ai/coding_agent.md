he core insight is that your likelihood of successfully solving a problem with a coding agent is strongly correlated with the agent's ability to verify its own work. We've spent a lot of time building out tests and other back-pressure mechanisms into our repository, and it remains one of the highest-leverage things we have spent time on.

early on we had our agent run the full test suite after every change, and 4,000 lines of passing tests would flood the context window. The agent would then lose track of the actual task and start hallucinating about test files it had just read. Now we swallow the output and only surface errors. We do the same with builds — success is silent, and only failures produce verbose output.



Technologies often described as “boring” tend to be easier for agents to model due to composability, api stability, and representation in the training set. In some cases, it was cheaper to have the agent reimplement subsets of functionality than to work around opaque upstream behavior from public libraries. For example, rather than pulling in a generic p-limit-style package, we implemented our own map-with-concurrency helper: it’s tightly integrated with our OpenTelemetry instrumentation, has 100% test coverage, and behaves exactly the way our runtime expects.

within each business domain (e.g. App Settings), code can only depend “forward” through a fixed set of layers (Types → Config → Repo → Service → Runtime → UI). Cross-cutting concerns (auth, connectors, telemetry, feature flags) enter through a single explicit interface: Providers. Anything else is disallowed and enforced mechanically.

You should treat your directory structure and file naming with the same thoughtfulness you’d treat any other interface. A file called ./billing/invoices/compute.ts communicates much more than ./utils/helpers.ts, even if the code inside is identical. Help the LLM out and give your files thoughtful organization.

Additionally, prefer many small well-scoped files.

In our setup, every npm test creates a brand new database, runs migrations, and executes the full suite.  This only works for us because we’ve made each of those stages exceptionally fast. We run tests with high concurrency, strong isolation, and a caching layer for third-party calls5. We have 10,000+ assertions that finish in about a minute. Without caching, it takes 20-30 minutes, which would add hours if you expected an agent to run tests several times per task.

Plans are treated as first-class artifacts. Ephemeral lightweight plans are used for small changes, while complex work is captured in execution plans with progress and decision logs that are checked into the repository.

A recurring “doc-gardening” agent scans for stale or obsolete documentation that does not reflect the real code behavior and opens fix-up pull requests.

To drive a PR to completion, we instruct Codex to review its own changes locally, request additional specific agent reviews both locally and in the cloud, respond to any human or agent given feedback, and iterate in a loop until all agent reviewers are satisfied (effectively this is a Ralph Wiggum Loop⁠(opens in a new window)). Codex uses our standard development tools directly (gh, local scripts, and repository-embedded skills) to gather context without humans copying and pasting into the CLI.

Humans may review pull requests, but aren’t required to. Over time, we’ve pushed almost all review effort towards being handled agent-to-agent.

For example, we made the app bootable per git worktree, so Codex could launch and drive one instance per change. We also wired the Chrome DevTools Protocol into the agent runtime and created skills for working with DOM snapshots, screenshots, and navigation. This enabled Codex to reproduce bugs, validate fixes, and reason about UI behavior directly.

We did the same for observability tooling. Logs, metrics, and traces are exposed to Codex via a local observability stack that’s ephemeral for any given worktree. Codex works on a fully isolated version of that app—including its logs and metrics, which get torn down once that task is complete. Agents can query logs with LogQL and metrics with PromQL. With this context available, prompts like “ensure service startup completes in under 800ms” or “no span in these four critical user journeys exceeds two seconds” become tractable.

We regularly see single Codex runs work on a single task for upwards of six hours (often while the humans are sleeping).

The repository operates with minimal blocking merge gates. Pull requests are short-lived. Test flakes are often addressed with follow-up runs rather than blocking progress indefinitely. In a system where agent throughput far exceeds human attention, corrections are cheap, and waiting is expensive.

This would be irresponsible in a low-throughput environment. Here, it’s often the right tradeoff.

Instead, we started encoding what we call “golden principles” directly into the repository and built a recurring cleanup process. These principles are opinionated, mechanical rules that keep the codebase legible and consistent for future agent runs. For example: (1) we prefer shared utility packages over hand-rolled helpers to keep invariants centralized, and (2) we don’t probe data “YOLO-style”—we validate boundaries or rely on typed SDKs so the agent can’t accidentally build on guessed shapes. On a regular cadence, we have a set of background Codex tasks that scan for deviations, update quality grades, and open targeted refactoring pull requests. Most of these can be reviewed in under a minute and automerged.






