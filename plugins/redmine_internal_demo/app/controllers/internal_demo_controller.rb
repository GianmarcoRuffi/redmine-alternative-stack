class InternalDemoController < ApplicationController
  skip_before_action :check_if_login_required, only: [:index]

  def index
    @demo_project = Project.find_by(identifier: RedmineInternalDemo::DemoSeed::PROJECT_IDENTIFIER)
    registered_plugins = Redmine::Plugin.all.map { |plugin| plugin.id.to_s }
    theme_paths = Redmine::Themes.themes.map(&:dir)

    @demo_sections = [
      {
        title: 'Perche valutare Redmine',
        items: [
          'costo ricorrente piu controllabile',
          'minore lock-in verso Atlassian',
          'liberta di hosting e ownership del dato'
        ]
      },
      {
        title: 'Cosa vogliamo mostrare internamente',
        items: [
          'issue tracking e workflow',
          'board e backlog tramite stack curato',
          'reporting, ruoli e migrazione disciplinata'
        ]
      },
      {
        title: 'Prossimi passi della demo',
        items: if @demo_project
                 [
                   'progetto demo gia caricato nella sandbox',
                   'issue, versioni e categorie pronte per il walkthrough',
                   'prossimo focus: backlog/board e percorso di migrazione'
                 ]
               else
                 [
                   'caricare dati e progetto dimostrativo',
                   'selezionare plugin iniziali',
                   'rafforzare il percorso Jira -> Redmine'
                 ]
               end
      }
    ]

    @comparison_rows = [
      ['Costo', 'licensing e app possono crescere nel tempo', 'base open source e stack controllabile'],
      ['Hosting', 'spinta forte verso il cloud', 'self-hosted, hosted o ibrido'],
      ['Board e backlog', 'forti nativamente', 'da rafforzare con plugin o add-on'],
      ['Migrazione', 'uscire richiede disciplina', 'da strutturare come capability chiave']
    ]

    @stack_components = [
      {
        name: 'additionals',
        type: 'Plugin',
        gap: 'UX/admin e miglioramenti trasversali',
        status: registered_plugins.include?('additionals') ? 'Installato' : 'Non installato'
      },
      {
        name: 'additional_tags',
        type: 'Plugin',
        gap: 'Tag e classificazione issue/progetti',
        status: registered_plugins.include?('additional_tags') ? 'Installato' : 'Non installato'
      },
      {
        name: 'redmine_issue_templates',
        type: 'Plugin',
        gap: 'Template issue e standard workflow',
        status: registered_plugins.include?('redmine_issue_templates') ? 'Installato' : 'Deferito'
      },
      {
        name: 'redmine_issue_todo_lists2',
        type: 'Plugin',
        gap: 'Checklist e to-do list sulle issue',
        status: registered_plugins.include?('redmine_issue_todo_lists2') ? 'Installato' : 'Deferito'
      },
      {
        name: 'redmine_wiki_extensions',
        type: 'Plugin',
        gap: 'Knowledge base e wiki piu ricca',
        status: registered_plugins.include?('redmine_wiki_extensions') ? 'Installato' : 'Non installato'
      },
      {
        name: 'periodictask',
        type: 'Plugin',
        gap: 'Issue ricorrenti e automazione leggera',
        status: registered_plugins.include?('periodictask') ? 'Installato' : 'Non installato'
      },
      {
        name: 'redmine_theme_changer',
        type: 'Plugin',
        gap: 'Selezione tema per utente/progetto',
        status: registered_plugins.include?('redmine_theme_changer') ? 'Installato' : 'Non installato'
      },
      {
        name: 'PurpleMine2',
        type: 'Tema',
        gap: 'UX visuale piu moderna',
        status: theme_paths.include?('PurpleMine2') ? 'Disponibile' : 'Non installato'
      },
      {
        name: 'opale',
        type: 'Tema',
        gap: 'Tema moderno alternativo',
        status: theme_paths.include?('opale') ? 'Disponibile' : 'Non installato'
      },
      {
        name: 'farend_bleuclair',
        type: 'Tema',
        gap: 'Tema moderno conservativo',
        status: theme_paths.include?('farend_bleuclair') ? 'Disponibile' : 'Non installato'
      },
      {
        name: 'Agile/board/backlog',
        type: 'Spike',
        gap: 'Board e backlog Jira-like',
        status: 'Da validare'
      }
    ]

    @stack_summary = {
      installed: @stack_components.count { |component| ['Installato', 'Disponibile'].include?(component[:status]) },
      pending: @stack_components.count { |component| component[:status] == 'Non installato' },
      deferred: @stack_components.count { |component| ['Da validare', 'Deferito'].include?(component[:status]) }
    }

    @demo_stats = if @demo_project
                    {
                      issues: @demo_project.issues.count,
                      versions: @demo_project.versions.count,
                      members: @demo_project.memberships.count
                    }
                  end
  end
end
