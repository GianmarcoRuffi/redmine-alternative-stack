require_dependency File.expand_path('lib/redmine_internal_demo/hooks', __dir__)
require_dependency File.expand_path('lib/redmine_internal_demo/demo_seed', __dir__)

Redmine::Plugin.register :redmine_internal_demo do
  name 'Redmine Internal Demo'
  author 'GitHub Copilot'
  description 'Internal demo page for presenting a Redmine-based Jira alternative.'
  version '0.1.0'

  menu :top_menu,
       :internal_demo,
       { controller: 'internal_demo', action: 'index' },
       caption: 'Redmine Demo',
       last: true
end