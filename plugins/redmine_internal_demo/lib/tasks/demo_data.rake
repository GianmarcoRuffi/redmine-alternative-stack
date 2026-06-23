namespace :redmine_internal_demo do
  desc 'Load or refresh the internal Redmine demo dataset'
  task seed: :environment do
    RedmineInternalDemo::DemoSeed.run
  end
end