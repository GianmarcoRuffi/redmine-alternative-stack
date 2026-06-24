# Redmine Alternative Stack

Workspace interno per pianificazione, ricerca e decisioni su una possibile alternativa a Jira basata su Redmine.

Obiettivo iniziale:
- usare il progetto internamente
- validare gap, migrazione e UX
- evolverlo in seguito verso una proposta per software house

## Struttura

- `docs/redmine-alternative-plan.md`: roadmap a 12 mesi, verifiche, decisioni e rischi
- `docs/sandbox-setup.md`: guida locale per la prima sandbox Redmine
- `research/jira-redmine-gap-matrix.md`: gap matrix e lettura strategica Jira vs Redmine
- `decisions/product-thesis.md`: tesi di prodotto, non-goal e principio di posizionamento
- `plugins/redmine_internal_demo`: primo plugin demo Redmine in Ruby on Rails

## Direzione del progetto

Linea di lavoro corrente:

- non proporre Redmine base come sostituto diretto di Jira
- costruire uno stack Redmine potenziato e curato
- validarlo prima internamente
- usarlo poi come base per un'offerta verso software house che vogliono ridurre dipendenza da Jira/Atlassian

## Current Implementation Status

The repository now contains a minimal Docker Compose scaffold for a local Redmine sandbox:

- `docker-compose.yml`
- `.env.example`
- `docs/sandbox-setup.md`

This is the first implementation step and is meant to support discovery, not production use.

Current demo route: `http://localhost:3000/internal-demo`

Demo data seed:

```bash
docker compose exec redmine sh -lc 'SECRET_KEY_BASE="$REDMINE_SECRET_KEY_BASE" bundle exec rake redmine_internal_demo:seed'
```
