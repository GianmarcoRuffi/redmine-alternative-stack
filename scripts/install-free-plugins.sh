#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGINS_DIR="${ROOT_DIR}/plugins"
THEMES_DIR="${ROOT_DIR}/themes"

ADDITIONALS_REF="${ADDITIONALS_REF:-4.4.0}"
ADDITIONAL_TAGS_REF="${ADDITIONAL_TAGS_REF:-4.4.0}"
ISSUE_TEMPLATES_REF="${ISSUE_TEMPLATES_REF:-1.1.0}"
WIKI_EXTENSIONS_REF="${WIKI_EXTENSIONS_REF:-1.2.0}"
PERIODIC_TASK_REF="${PERIODIC_TASK_REF:-v6.1.3}"
THEME_CHANGER_REF="${THEME_CHANGER_REF:-0.7.1}"
TODO_LISTS_REF="${TODO_LISTS_REF:-2.1.8}"
PURPLEMINE2_REF="${PURPLEMINE2_REF:-v2.9.1}"
OPALE_REF="${OPALE_REF:-1.6.7}"
FAREND_BLEUCLAIR_REF="${FAREND_BLEUCLAIR_REF:-v2.0.3}"
INCLUDE_ISSUE_TEMPLATES="${INCLUDE_ISSUE_TEMPLATES:-0}"
INCLUDE_TODO_LISTS="${INCLUDE_TODO_LISTS:-0}"

install_git_asset() {
  local name="$1"
  local repo_url="$2"
  local ref="$3"
  local target_dir="$4"

  mkdir -p "$(dirname "${target_dir}")"

  if [ -d "${target_dir}/.git" ]; then
    printf 'Updating %s in %s\n' "${name}" "${target_dir}"
    git -C "${target_dir}" fetch --tags --prune origin
  elif [ -e "${target_dir}" ]; then
    printf 'Refusing to overwrite non-git path: %s\n' "${target_dir}" >&2
    exit 1
  else
    printf 'Cloning %s into %s\n' "${name}" "${target_dir}"
    git clone "${repo_url}" "${target_dir}"
  fi

  git -C "${target_dir}" checkout --detach "${ref}"
  printf '%s pinned to %s (%s)\n' "${name}" "${ref}" "$(git -C "${target_dir}" rev-parse --short HEAD)"
}

install_git_asset \
  "additionals" \
  "https://github.com/alphanodes/additionals.git" \
  "${ADDITIONALS_REF}" \
  "${PLUGINS_DIR}/additionals"

install_git_asset \
  "additional_tags" \
  "https://github.com/alphanodes/additional_tags.git" \
  "${ADDITIONAL_TAGS_REF}" \
  "${PLUGINS_DIR}/additional_tags"

if [ "${INCLUDE_ISSUE_TEMPLATES}" = "1" ]; then
  install_git_asset \
    "redmine_issue_templates" \
    "https://github.com/akiko-pusu/redmine_issue_templates.git" \
    "${ISSUE_TEMPLATES_REF}" \
    "${PLUGINS_DIR}/redmine_issue_templates"
else
  printf 'Skipping redmine_issue_templates by default; Redmine 6.1 audit is deferred. Set INCLUDE_ISSUE_TEMPLATES=1 to test it.\n'
fi

install_git_asset \
  "redmine_wiki_extensions" \
  "https://github.com/haru/redmine_wiki_extensions.git" \
  "${WIKI_EXTENSIONS_REF}" \
  "${PLUGINS_DIR}/redmine_wiki_extensions"

install_git_asset \
  "periodictask" \
  "https://github.com/jperelli/Redmine-Periodic-Task.git" \
  "${PERIODIC_TASK_REF}" \
  "${PLUGINS_DIR}/periodictask"

install_git_asset \
  "redmine_theme_changer" \
  "https://github.com/haru/redmine_theme_changer.git" \
  "${THEME_CHANGER_REF}" \
  "${PLUGINS_DIR}/redmine_theme_changer"

if [ "${INCLUDE_TODO_LISTS}" = "1" ]; then
  install_git_asset \
    "redmine_issue_todo_lists2" \
    "https://github.com/jcatrysse/redmine_issue_todo_lists2.git" \
    "${TODO_LISTS_REF}" \
    "${PLUGINS_DIR}/redmine_issue_todo_lists2"
else
  printf 'Skipping redmine_issue_todo_lists2 by default; Redmine 6.1 audit is deferred. Set INCLUDE_TODO_LISTS=1 to test it.\n'
fi

install_git_asset \
  "PurpleMine2" \
  "https://github.com/mrliptontea/PurpleMine2.git" \
  "${PURPLEMINE2_REF}" \
  "${THEMES_DIR}/PurpleMine2"

install_git_asset \
  "opale" \
  "https://github.com/gagnieray/opale.git" \
  "${OPALE_REF}" \
  "${THEMES_DIR}/opale"

install_git_asset \
  "farend_bleuclair" \
  "https://github.com/farend/redmine_theme_farend_bleuclair.git" \
  "${FAREND_BLEUCLAIR_REF}" \
  "${THEMES_DIR}/farend_bleuclair"

cat <<'NEXT_STEPS'

Installed approved free plugin/theme assets. Next steps:

  docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle install'
  docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle exec rake redmine:plugins:migrate RAILS_ENV=production'
  docker compose restart redmine

Then verify /admin/plugins and choose a theme from Redmine administration.
redmine_issue_templates is intentionally not installed by default because the first Redmine 6.1 load test failed.
redmine_issue_todo_lists2 is intentionally not installed by default because the first Redmine 6.1 migration test failed.
NEXT_STEPS
