# Free Plugin Matrix

## Purpose

This matrix tracks the first free/OSS wave for the Redmine alternative stack. It is intentionally conservative: a plugin is installable only when the source is public, the license/use is free and non-temporary, and the sandbox smoke test is repeatable on Redmine 6.1.

## Vetting Rules

- Baseline: Redmine `6.1` from the official Docker image.
- Third-party code is installed locally by script and is not committed to this repository.
- Every installed plugin or theme must be pinned to a tag or commit.
- A candidate becomes approved only after `docker compose config`, plugin/theme installation, migrations, restart, and manual smoke test.
- Plugins that cover an important gap but fail compatibility or maintenance checks remain documented as deferred, not force-installed.

## Approved Install Set

| Component | Type | Gap covered | Source | Pin | License/free status | Redmine 6.1 status | Maintenance signal | Risk | Decision |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `additionals` | Plugin | UX/admin improvements, dashboards, and cross-cutting Redmine enhancements | https://github.com/alphanodes/additionals | `4.4.0` | Public source, free use to verify from upstream license before pilot | Migration and boot passed | Active upstream with recent stable tags | Broad surface area can affect admin and UI behavior | Install by default |
| `additional_tags` | Plugin | Tags/classification for issues and projects | https://github.com/alphanodes/additional_tags | `4.4.0` | Public source, free use to verify from upstream license before pilot | Migration and boot passed | Active upstream with recent stable tags | Depends on Redmine internals around tagged entities | Install by default |
| `redmine_wiki_extensions` | Plugin | Knowledge base improvements: wiki comments, tags, macros, navigation helpers | https://github.com/haru/redmine_wiki_extensions | `1.2.0` | Public source, free use to verify from upstream license before pilot | Migration and boot passed; emits Rails dynamic route deprecation warnings | Recent Redmine 6.x release branch/tag | Route deprecations may need attention before future Rails upgrades | Install by default |
| `periodictask` | Plugin | Lightweight automation via recurring issue generation | https://github.com/jperelli/Redmine-Periodic-Task | `v6.1.3` | Public source, free use to verify from upstream license before pilot | Migration and boot passed | Recent tag aligned with Redmine 6.1 | Adds scheduled-task operational process to document | Install by default |
| `redmine_theme_changer` | Plugin | Per-user/per-project theme selection for UX trials | https://github.com/haru/redmine_theme_changer | `0.7.1` | Public source, free use to verify from upstream license before pilot | Migration and boot passed | Public release tags | Adds another UI setting surface | Install by default |
| `PurpleMine2` | Theme | Better first impression and cleaner UI baseline | https://github.com/mrliptontea/PurpleMine2 | `v2.9.1` | Public source, free use to verify from upstream license before pilot | Theme registered and boot passed | Maintained public theme with tagged releases | Theme may not cover every plugin screen | Install by default |
| `opale` | Theme | Modern alternative theme for UX comparison | https://github.com/gagnieray/opale | `1.6.7` | Public source, free use to verify from upstream license before pilot | Theme registered and boot passed | Has Redmine 6.x branch and tagged releases | Needs visual review on key plugin screens | Install by default |
| `farend_bleuclair` | Theme | Conservative modern theme option | https://github.com/farend/redmine_theme_farend_bleuclair | `v2.0.3` | Public source, free use to verify from upstream license before pilot | Theme registered and boot passed | Stable branch and Redmine 6 tags | Less distinctive than Opale/PurpleMine2 | Install by default |

## Deferred Candidates (Plugin Load Failures)

| Component | Type | Gap covered | Source | Pin | Issue | Workaround | Decision |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `redmine_issue_templates` | Plugin | Issue templates and workflow standardization | https://github.com/akiko-pusu/redmine_issue_templates | `1.1.0` | Failed Redmine 6.1 load: `cannot load such file -- issue_templates/issues_hook` | **Wiki-based template library** (see Workaround Solutions) | Deferred; use workaround |
| `redmine_issue_todo_lists2` | Plugin | Checklist/to-do lists inside issues | https://github.com/jcatrysse/redmine_issue_todo_lists2 | `2.1.8` | Failed Redmine 6.1 migration: ActiveRecord 7 `serialize` signature mismatch | **Parent/child issue hierarchy** (native Redmine, see Workaround Solutions) | Deferred; use workaround |
| Agile/board/backlog plugin | Plugin | Board and backlog workflows | TBD | TBD | High dependency risk; no compatible OSS candidate identified | Deferred to separate spike | Deferred to separate spike |

## Workaround Solutions (OSS/Low-Tech Alternatives)

| Gap | Plugin failed | Workaround strategy | How to use | Trade-offs |
| --- | --- | --- | --- | --- |
| **Issue templates** | `redmine_issue_templates` | Wiki-based template library + custom field presets | Create a dedicated wiki page per template; copy structure and fill custom fields manually or via API | Lower UX polish than plugin; requires discipline; no form validation |
| **Checklists** | `redmine_issue_todo_lists2` | Parent/child issue hierarchy (native Redmine) | Create parent issue, add child issues for each checklist item; use status/resolution to track completion | No inline checklist UI; requires filtering/view setup; integrates with `periodictask` for recurring checklist generation |
| **Checklists** (commercial alternative) | `redmine_issue_todo_lists2` | `redmine_checklists` (RedmineUP PRO) | Install RedmineUP checklists plugin; supports native inline checklists + `periodictask` integration | Commercial license required; vendor lock-in with RedmineUP ecosystem; not free/OSS |
| **Templates** (via wiki macros) | `redmine_issue_templates` | `redmine_wiki_extensions` macro library | Use `{{wiki(TemplatePage)}}` macro to embed template content in wiki; extend with custom macros if needed | Requires wiki knowledge; UX is wiki-centric, not forms-based |

## Current Gap Coverage

| Gap | Wave 1 coverage | Workaround available | Status |
| --- | --- | --- | --- |
| Issue templates | `redmine_issue_templates` (deferred) | Wiki-based library + custom fields | ✅ Low-tech workaround in place; plugin audit deferred |
| Checklist/to-do lists | `redmine_issue_todo_lists2` (deferred) | Parent/child issues (OSS) or `redmine_checklists` (commercial) | ✅ OSS workaround in place; commercial option documented |
| Tags/classification | `additional_tags` | N/A | Installed in sandbox |
| General UX/admin polish | `additionals`, `redmine_theme_changer`, `PurpleMine2`, `opale`, `farend_bleuclair` | N/A | Installed in sandbox |
| Wiki/knowledge base | `redmine_wiki_extensions` | Built-in macros + template embedding | Installed in sandbox |
| Boards/backlog | None yet | Deferred spike | Deferred to separate spike |
| Reporting/dashboard | `additionals` dashboard capability | N/A | Partial Wave 1 coverage; deeper PM reporting remains future work |
| Automation | `periodictask` recurring issues | N/A | Partial coverage; event/rule automation remains future work; integrates with checklist workarounds |
| Jira migration | Not covered by plugin | Separate runbook/tooling | Separate runbook/tooling |

## Previous Gap Coverage Table (Archived)

| Gap | Wave 1 coverage | Status |
| --- | --- | --- |
| Issue templates | `redmine_issue_templates` | Deferred after failed Redmine 6.1 load test |
| Checklist/to-do lists | `redmine_issue_todo_lists2` | Deferred after failed Redmine 6.1 migration test |

## Current Gap Coverage

| Gap | Wave 1 coverage | Status |
| --- | --- | --- |
| Issue templates | `redmine_issue_templates` | Deferred after failed Redmine 6.1 load test |
| Checklist/to-do lists | `redmine_issue_todo_lists2` | Deferred after failed Redmine 6.1 migration test |
| Tags/classification | `additional_tags` | Candidate install |
| General UX/admin polish | `additionals`, `redmine_theme_changer`, `PurpleMine2`, `opale`, `farend_bleuclair` | Installed in sandbox |
| Wiki/knowledge base | `redmine_wiki_extensions` | Installed in sandbox |
| Boards/backlog | None yet | Deferred spike |
| Reporting/dashboard | `additionals` dashboard capability | Partial Wave 1 coverage; deeper PM reporting remains future work |
| Automation | `periodictask` recurring issues | Partial coverage; event/rule automation remains future work |
| Jira migration | Not covered by plugin | Separate runbook/tooling |

## Smoke Test Checklist

### Plugin Installation and Boot
1. Install approved assets with `scripts/install-free-plugins.sh`.
2. Run Redmine plugin migrations.
3. Restart the Redmine container.
4. Confirm `/admin/plugins` lists the installed plugins.

### Themes and UI
5. Try `PurpleMine2`, `opale`, and `farend_bleuclair` from Redmine administration and inspect key pages.

### Features and Workarounds
6. **Tags**: Add and search/filter tags using `additional_tags`.
7. **Recurring tasks**: Create or inspect a recurring task configuration using `periodictask`.
8. **Wiki and templates**: 
   - Open wiki pages and verify Wiki Extensions menu/macros are available.
   - Create a test wiki page with `{{wiki(OtherPage)}}` macro to test template embedding workaround.
9. **Checklists (parent/child workaround)**:
   - Create a parent issue and 3 child issues to simulate a checklist.
   - Verify filtering by issue hierarchy works.
   - Test closing child issues to track completion.
10. **Admin and diagnostics**:
    - Open `/internal-demo` and confirm the plugin stack section reflects installed/missing components.
    - Verify deferred plugins (`redmine_issue_templates`, `redmine_issue_todo_lists2`) are not loaded.

### Audit Mode (Optional)
- Run `INCLUDE_ISSUE_TEMPLATES=1` or `INCLUDE_TODO_LISTS=1` only for isolated audits.
- Remove the plugin again before restarting the shared sandbox if the Redmine 6.1 error persists.
