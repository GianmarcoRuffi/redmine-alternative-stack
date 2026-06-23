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

## Notes

- This setup is intentionally minimal and does not yet include curated plugins, themes, or migration tooling.
- The repository now includes a first demo plugin in `plugins/redmine_internal_demo` implemented as a Redmine plugin in Ruby on Rails.
- The same plugin also ships a repeatable demo-data seed task that creates a public project, versions, categories, and representative issues.
- The current purpose is discovery and workflow validation, not production readiness.
- If the discovery phase succeeds, the next implementation step should be plugin selection, theme direction, and sandbox hardening.
- In the current environment, the compose file validates successfully and the internal demo page is reachable once the containers are up.