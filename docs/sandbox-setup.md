# Redmine Sandbox Setup

## Purpose

This sandbox is the first implementation artifact for the project. Its goal is to give the team a fast way to validate Redmine as a potential Jira alternative without committing yet to product development.

## What is included

- PostgreSQL database
- Redmine application
- named Docker volumes for database, files, plugins, and themes

## Local setup

Prerequisite: the current user must be allowed to access `/var/run/docker.sock`. On Linux this usually means being part of the `docker` group or using an equivalent Docker Desktop configuration.

1. Copy the example environment file:

   ```bash
   cp .env.example .env
   ```

2. Replace `POSTGRES_PASSWORD` and `REDMINE_SECRET_KEY_BASE` with real values.

3. Start the sandbox:

   ```bash
   docker compose up -d
   ```

4. Follow logs if needed:

   ```bash
   docker compose logs -f redmine
   ```

5. Open the application at `http://localhost:3000` unless `REDMINE_PORT` was changed.

6. Open the internal demo page at `http://localhost:3000/internal-demo`.

7. Load the demo project dataset when needed:

   ```bash
   docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle exec rake redmine_internal_demo:seed'
   ```

## Free plugin wave

The first curated wave is documented in `docs/free-plugin-matrix.md`. Third-party plugins and themes are installed locally and ignored by Git, so the repository tracks the approved sources and pins without vendoring external code.

1. Install or update the approved Wave 1 assets:

   ```bash
   scripts/install-free-plugins.sh
   ```

2. Install plugin dependencies inside the Redmine container when a plugin ships a `Gemfile`:

   ```bash
   docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle install'
   ```

3. Run plugin migrations:

   ```bash
   docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle exec rake redmine:plugins:migrate RAILS_ENV=production'
   ```

4. Restart Redmine:

   ```bash
   docker compose restart redmine
   ```

5. Verify the installation:

   - open `http://localhost:3000/admin/plugins`
   - confirm `additionals`, `additional_tags`, `periodictask`, `redmine_theme_changer`, and `redmine_wiki_extensions` are listed
   - try `PurpleMine2`, `opale`, and `farend_bleuclair` from Redmine administration
   - add and filter tags
   - create or inspect a recurring task setup
   - inspect wiki pages with Wiki Extensions enabled
   - reopen `http://localhost:3000/internal-demo` and check the plugin stack section

Plugin pins can be overridden for an audit run:

```bash
ADDITIONALS_REF=4.4.0 \
ADDITIONAL_TAGS_REF=4.4.0 \
ISSUE_TEMPLATES_REF=1.1.0 \
WIKI_EXTENSIONS_REF=1.2.0 \
PERIODIC_TASK_REF=v6.1.3 \
THEME_CHANGER_REF=0.7.1 \
TODO_LISTS_REF=2.1.8 \
PURPLEMINE2_REF=v2.9.1 \
OPALE_REF=1.6.7 \
FAREND_BLEUCLAIR_REF=v2.0.3 \
scripts/install-free-plugins.sh
```

`redmine_issue_templates` is not installed by default because the first Redmine 6.1 migration test failed during plugin load with `cannot load such file -- issue_templates/issues_hook`. To audit it in isolation, run:

```bash
INCLUDE_ISSUE_TEMPLATES=1 scripts/install-free-plugins.sh
```

Remove `plugins/redmine_issue_templates` again before restarting the shared sandbox if the same error is still present.

`redmine_issue_todo_lists2` is also not installed by default because the first Redmine 6.1 migration test failed with an ActiveRecord 7 `serialize` signature mismatch. To audit it in isolation, run:

```bash
INCLUDE_TODO_LISTS=1 scripts/install-free-plugins.sh
```

Remove `plugins/redmine_issue_todo_lists2` again before restarting the shared sandbox if the same error is still present.

## Working Around Deferred Plugins: Templates and Checklists

Since `redmine_issue_templates` and `redmine_issue_todo_lists2` are not compatible with Redmine 6.1 + Rails 7.2, the following low-tech workarounds are documented and tested as part of the standard stack:

### Templates Workaround: Wiki-Based Template Library

**How to use:**
1. Create a wiki page in the project called `TemplateLibrary` or `IssueTemplates`.
2. Document the structure and custom fields for each issue type (e.g., "Bug Report Template", "Feature Request Template").
3. When creating a new issue, copy the relevant template content and fill in the custom fields manually.
4. Optionally, set up a custom field with predefined values to enforce consistency.

**Example wiki template page:**
```
h2. Bug Report Template

* *Severity*: [Select: Critical, High, Medium, Low]
* *Environment*: [Describe OS, browser, Redmine version]
* *Steps to Reproduce*: [List steps clearly]
* *Expected Result*: [What should happen]
* *Actual Result*: [What actually happens]
```

**Advantages:**
- Works immediately; no plugin install needed.
- Version-controlled if wiki is backed by Git.
- Easy to customize per-project.

**Limitations:**
- No form validation or auto-fill.
- Requires user discipline.
- UX is not as polished as a dedicated plugin.

### Checklists Workaround: Parent/Child Issue Hierarchy

**How to use:**
1. Create a parent issue (e.g., "User Story: Authentication Flow").
2. Create child issues (one per checklist item).
3. Assign child issues to team members and track via status/resolution.
4. Parent issue status summarizes completion of all children.

**Example:**
```
Parent: "Implement login feature" (Story)
  ├─ Child: "Design login form" (Task) → In Progress
  ├─ Child: "Integrate password validation" (Task) → Closed
  ├─ Child: "Add 2FA support" (Task) → New
  └─ Child: "Write tests" (Task) → New
```

**Setup in Redmine:**
- Use **Issue queries** to filter and group by parent.
- Use **Gantt chart** or **Timeline** to visualize parent/child workflow.
- If `periodictask` is installed, set it to create recurring parent issues with a standard set of child templates.

**Advantages:**
- Native Redmine feature; no plugin needed.
- Works with existing `periodictask` for recurring templates.
- Integrates with permissions and workflows.

**Limitations:**
- No inline checklist UI; requires view changes to visualize completion %.
- Heavier than a simple checklist for small tasks.

### Commercial Alternative: RedmineUP Checklists

Teams that need inline checklists with a polish comparable to `redmine_issue_todo_lists2` can use **`redmine_checklists`** from [RedmineUP](https://www.redmineup.com/pages/plugins/checklists):
- Supports Redmine 6.1 and Rails 7.2.
- Integrates natively with `periodictask` for recurring checklist generation.
- Commercial license required.

## Notes

- This setup is intentionally minimal and does not yet include curated plugins, themes, or migration tooling.
- The repository now includes a first demo plugin in `plugins/redmine_internal_demo` implemented as a Redmine plugin in Ruby on Rails.
- The same plugin also ships a repeatable demo-data seed task that creates a public project, versions, categories, and representative issues.
- The current purpose is discovery and workflow validation, not production readiness.
 - The demo seed now also creates a sample `IssueTemplates` wiki page and a sample parent issue with child checklist items to demonstrate the documented workarounds.
- If the discovery phase succeeds, the next implementation step should be sandbox hardening, a board/backlog plugin spike, and migration runbook work.
- In the current environment, the compose file validates successfully and the internal demo page is reachable once the containers are up.
