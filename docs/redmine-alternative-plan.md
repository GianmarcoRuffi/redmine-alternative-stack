# Redmine Alternative Stack Plan

## Goal

Build over 12 months an internal Redmine-based platform that can later become a credible alternative to Jira for software houses, after closing the most visible functional gaps and validating migration, UX, and day-to-day operability in a real environment.

## Strategic Framing

The product should not be positioned as plain Redmine. It should be positioned as a curated Redmine-based stack that improves on the areas where Jira and the Atlassian ecosystem are currently criticized most: recurring cost, lock-in, forced cloud direction, administrative complexity, plugin sprawl, and migration friction.

The initial advantage is not feature parity with Jira. The initial advantage is better control, lower lock-in, lower total cost, and enough operational depth to be viable for software teams.

## 12-Month Roadmap

### Phase 0: Thesis and Boundaries

1. Define the exact complaints against Jira we want to beat first: pricing, vendor lock-in, cloud pressure, admin complexity, plugin dependency, UX heaviness, and migration pain.
2. Define what not to do in year one: no enterprise parity, no broad AI parity, no attempt to replicate the Atlassian Marketplace, no advanced service management as a first-class product line.
3. Establish success KPIs for the first year: internal adoption, migration feasibility, closure of critical functional gaps, demo readiness, and first external pilot readiness.

### Q1: Fit-Gap and Technical Stack

1. Build a Jira vs Redmine vs enhanced Redmine fit-gap matrix.
2. Select a baseline Redmine version and supporting stack.
3. Shortlist plugins, theme direction, and integration approach.
4. Define technical rules of extension:
   - themes for UI and branding
   - plugins for product features
   - REST API for integrations and migration
   - no invasive core patching except as a last resort
5. Evaluate Planio and RedmineUP as accelerators, not as strategic dependencies.
6. Define a plugin vetting policy before adding any plugin to the stack. Minimum criteria: last release within 12 months, compatible with the selected Redmine version, at least one active maintainer, public issue tracker. Plugins that do not meet these criteria should not enter the recommended stack regardless of feature fit.

### Q1: Internal Sandbox

1. Set up a Redmine sandbox.
2. Map 8-10 real internal workflows: backlog, board usage, issue management, permissions, time tracking, reporting, attachments, notifications, and knowledge capture.
3. Produce gap list v1 based on actual usage scenarios.

### Q2: Internal Dogfooding

1. Move at least one real internal project onto the platform.
2. Use it as the daily operating environment long enough to expose real pain points.
3. Prioritize what blocks adoption first: UX friction, missing board behavior, weak reporting, awkward workflow administration, weak automation, or missing developer integrations.
4. Involve at least one external observer informally during this phase: a contact at a software house who is willing to review the environment and react to it. Internal use alone risks validating against a simpler case than the actual target customer.

### Q2: Gap Closure

1. Improve the areas that stop real use first.
2. Build or integrate only what increases adoption probability.
3. Keep the stack maintainable and upgrade-safe.

### Q2: Technical Spike

1. Build at least one small proprietary add-on.
2. Measure implementation effort, testability, compatibility, upgrade risk, and maintenance cost.
3. Use the spike to decide where proprietary IP makes sense.

### Q2: Migration Proof of Concept

1. Design an initial Jira to Redmine migration flow.
2. Map core entities: issues, users, comments, attachments, statuses, roles, and custom fields.
3. Produce migration runbook v1 and identify hard blockers early.

### Q3: Productization

1. Turn the internal environment into a repeatable stack.
2. Build a list of approved plugins and supported configurations.
3. Define upgrade criteria, install checklist, migration checklist, and standard setup profiles for software houses.
4. Prepare a credible demo environment.

### Q3: Commercial Packaging

1. Define three initial offerings:
   - Jira exit assessment
   - guided migration
   - managed enhanced Redmine stack
2. Keep the project internal-first, but make it externally explainable.

### Q3: Partner Strategy

1. Decide whether Planio should be used for hosting credibility or delivery acceleration.
2. Decide whether RedmineUP should be used for plugin, theme, and training acceleration.
3. Keep partner dependency optional.

### Q4: Design Partners and Pilot

1. Identify 1-2 software houses willing to act as design partners.
2. Prioritize teams with real Jira frustration, medium complexity, and openness to mild workflow redesign.
3. Run at least one guided external pilot.
4. Measure migration success, adoption quality, supportability, and customization effort.

### Q4: Strategic Decision Point

At the end of the first year, decide whether the second-year strategy should focus on:
- managed platform
- migration factory
- proprietary add-ons
- or a combination of the three

## Verification Criteria

1. By end of Q1: fit-gap matrix with at least 20 capabilities and a working sandbox.
2. By end of Q2: at least one real internal project operating on the platform.
3. By end of Q2: one add-on spike and one Jira-to-Redmine migration proof of concept.
4. By end of Q3: clear offerings, demoable stack, and repeatable configuration.
5. By end of Q4: at least one active design partner or one external pilot.

## Key Decisions

- The platform must be built as enhanced Redmine, not plain Redmine.
- The first win is not total feature parity, but better control, lower lock-in, and lower cost.
- Partnerships accelerate delivery but should not define product strategy.
- Internal use is a credibility mechanism, not just testing.

## Risks

**Premature positioning.** The main risk is positioning too early as better than Jira before closing the most visible operational gaps. If presented too early, the product will be judged against Jira where Jira is strongest and will lose. The offer must reach the market only after it is already curated, validated, and demonstrably usable.

**Plugin ecosystem health.** Redmine's plugin ecosystem is built on Ruby on Rails and has been active since the mid-2000s. Some plugins have low contributor counts, infrequent releases, or untested upgrade paths. Adopting an unmaintained plugin creates a hidden debt that surfaces when Redmine upgrades. Mitigation: apply the plugin vetting policy from Q1 without exception and plan a plugin audit as part of any major version upgrade.

**Competitive landscape mismatch.** The target audience is not choosing only between Jira and Redmine. Plane, YouTrack, and GitLab Issues are credible alternatives in the same self-hosting space. Without a clear answer to why Redmine over these, the positioning will be fragile. Mitigation: complete the wider competitive analysis as a named deliverable in Q1.

**Target persona ambiguity.** "Software house" spans a wide range of team sizes, technical profiles, and process complexity. A ten-person shop building websites has fundamentally different needs from an eighty-person team managing multi-client software projects. Proceeding with gap analysis before narrowing the persona risks optimizing for the wrong use case. Mitigation: define at least one primary and one secondary persona with explicit size, process maturity, and pain profile before completing the fit-gap work.

**Planio competitive overlap.** Planio already occupies a similar position: hosted Redmine with commercial support and credibility in the Redmine community. Without a clear differentiator, this project risks building something that Planio already offers. Mitigation: explicitly map the overlap and define the differentiation before any commercial packaging work. Possible differentiators include geographic focus, deeper migration tooling, proprietary add-ons, or a more opinionated out-of-the-box configuration.
