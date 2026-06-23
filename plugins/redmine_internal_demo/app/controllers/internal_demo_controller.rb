class InternalDemoController < ApplicationController
  skip_before_action :check_if_login_required, only: [:index]

  def index
    @demo_project = Project.find_by(identifier: RedmineInternalDemo::DemoSeed::PROJECT_IDENTIFIER)

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

    @demo_stats = if @demo_project
                    {
                      issues: @demo_project.issues.count,
                      versions: @demo_project.versions.count,
                      members: @demo_project.memberships.count
                    }
                  end
  end
end