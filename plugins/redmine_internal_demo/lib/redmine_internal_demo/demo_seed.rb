module RedmineInternalDemo
  class DemoSeed
    PROJECT_IDENTIFIER = 'delivery-modernization-pilot'.freeze

    PROJECT_MODULES = %w[
      issue_tracking
      time_tracking
      news
      documents
      files
      wiki
      calendar
      gantt
    ].freeze

    USERS = [
      {
        key: :product_owner,
        login: 'product.owner',
        firstname: 'Product',
        lastname: 'Owner',
        mail: 'product.owner@example.test'
      },
      {
        key: :tech_lead,
        login: 'tech.lead',
        firstname: 'Tech',
        lastname: 'Lead',
        mail: 'tech.lead@example.test'
      },
      {
        key: :qa_lead,
        login: 'qa.lead',
        firstname: 'QA',
        lastname: 'Lead',
        mail: 'qa.lead@example.test'
      }
    ].freeze

    ISSUE_BLUEPRINTS = [
      {
        subject: 'Pilot backlog governance',
        tracker_index: 1,
        status_index: 1,
        priority_index: 2,
        assignee: :product_owner,
        category: 'Governance',
        version: 'Discovery Sprint',
        start_offset: 0,
        due_offset: 6,
        done_ratio: 40,
        estimated_hours: 12,
        description: 'Define the first backlog taxonomy, triage rules, and demo storyline for internal stakeholders.'
      },
      {
        subject: 'Map Jira workflow to Redmine statuses',
        tracker_index: 1,
        status_index: 2,
        priority_index: 3,
        assignee: :tech_lead,
        category: 'Workflow',
        version: 'Discovery Sprint',
        start_offset: 1,
        due_offset: 8,
        done_ratio: 65,
        estimated_hours: 10,
        description: 'Translate the current Jira lifecycle into a first Redmine workflow that is simple enough for the pilot.'
      },
      {
        subject: 'Validate role-based issue visibility',
        tracker_index: 0,
        status_index: 3,
        priority_index: 3,
        assignee: :qa_lead,
        category: 'Permissions',
        version: 'Discovery Sprint',
        start_offset: 2,
        due_offset: 9,
        done_ratio: 80,
        estimated_hours: 6,
        description: 'Check whether reporter, developer, and manager roles expose the right information for the demo.'
      },
      {
        subject: 'Prepare Jira import dry run',
        tracker_index: 2,
        status_index: 2,
        priority_index: 2,
        assignee: :tech_lead,
        category: 'Migration',
        version: 'Pilot Rollout',
        start_offset: 4,
        due_offset: 14,
        done_ratio: 20,
        estimated_hours: 14,
        description: 'Document the field mapping and prepare a dry-run import plan for two representative Jira projects.'
      },
      {
        subject: 'Fix external stakeholder notifications',
        tracker_index: 0,
        status_index: 0,
        priority_index: 4,
        assignee: :qa_lead,
        category: 'Notifications',
        version: 'Pilot Rollout',
        start_offset: 5,
        due_offset: 12,
        done_ratio: 0,
        estimated_hours: 5,
        description: 'Review which events should notify internal users only and which ones should be exposed to customer-facing stakeholders.'
      },
      {
        subject: 'Create internal adoption dashboard',
        tracker_index: 1,
        status_index: 0,
        priority_index: 1,
        assignee: :product_owner,
        category: 'Reporting',
        version: 'Pilot Rollout',
        start_offset: 8,
        due_offset: 18,
        done_ratio: 10,
        estimated_hours: 9,
        description: 'Define a minimal reporting view for issue flow, aging, and project health during the pilot.'
      }
    ].freeze

    RELATIONS = [
      ['Pilot backlog governance', 'Map Jira workflow to Redmine statuses', 'precedes', 1],
      ['Map Jira workflow to Redmine statuses', 'Prepare Jira import dry run', 'precedes', 2],
      ['Validate role-based issue visibility', 'Fix external stakeholder notifications', 'blocks', nil]
    ].freeze

    class << self
      def run(output: $stdout, language: default_language)
        ensure_default_data!(language)

        admin = User.where(admin: true).first || raise('No admin user found in Redmine')
        roles = default_roles
        users = ensure_users!
        project = ensure_project!
        ensure_memberships!(project, users, roles)
        versions = ensure_versions!(project)
        categories = ensure_categories!(project)
        issues = ensure_issues!(project, admin, users, versions, categories)
        ensure_relations!(issues)

        output.puts "Seeded project=#{project.identifier} issues=#{issues.size} versions=#{versions.size} users=#{users.size}"
      end

      private

      def ensure_default_data!(language)
        if Redmine::DefaultData::Loader.no_data?
          Redmine::DefaultData::Loader.load(language)
          return
        end

        return if Tracker.exists? && IssueStatus.exists? && default_priorities.exists? && Role.where(builtin: 0).exists?

        raise 'Redmine default data is partially loaded. Reset the sandbox or complete the missing configuration before seeding demo data.'
      end

      def ensure_users!
        USERS.each_with_object({}) do |attributes, users|
          user = User.find_or_initialize_by(login: attributes[:login])
          user.firstname = attributes[:firstname]
          user.lastname = attributes[:lastname]
          user.mail = attributes[:mail]
          user.language = default_language

          if user.new_record?
            user.password = 'ChangeMe123!'
            user.password_confirmation = 'ChangeMe123!'
          end

          user.save!
          users[attributes[:key]] = user
        end
      end

      def ensure_project!
        project = Project.find_or_initialize_by(identifier: PROJECT_IDENTIFIER)
        project.name = 'Delivery Modernization Pilot'
        project.description = 'Internal pilot project used to validate Redmine as a curated Jira alternative.'
        project.is_public = true
        project.enabled_module_names = PROJECT_MODULES
        project.trackers = Tracker.order(:position).to_a
        project.save!
        project
      end

      def ensure_memberships!(project, users, roles)
        {
          product_owner: roles.fetch(:manager),
          tech_lead: roles.fetch(:developer),
          qa_lead: roles.fetch(:reporter)
        }.each do |user_key, role|
          member = Member.find_or_initialize_by(project: project, user: users.fetch(user_key))
          member.role_ids = [role.id]
          member.save!
        end
      end

      def ensure_versions!(project)
        [
          ['Discovery Sprint', Date.today + 14],
          ['Pilot Rollout', Date.today + 30]
        ].map do |name, effective_date|
          version = project.versions.find_or_initialize_by(name: name)
          version.description = "Demo milestone for #{name.downcase}."
          version.status = 'open'
          version.effective_date = effective_date
          version.save!
          version
        end
      end

      def ensure_categories!(project)
        %w[Governance Workflow Permissions Migration Notifications Reporting].each_with_object({}) do |name, categories|
          category = project.issue_categories.find_or_initialize_by(name: name)
          category.save!
          categories[name] = category
        end
      end

      def ensure_issues!(project, admin, users, versions, categories)
        trackers = Tracker.order(:position).to_a
        statuses = IssueStatus.order(:position).to_a
        priorities = default_priorities.order(:position).to_a
        versions_by_name = versions.index_by(&:name)

        ISSUE_BLUEPRINTS.map do |blueprint|
          issue = Issue.find_or_initialize_by(project: project, subject: blueprint[:subject])
          issue.author = admin
          issue.tracker = trackers.fetch(blueprint[:tracker_index])
          issue.status = statuses.fetch(blueprint[:status_index])
          issue.priority = priorities.fetch(blueprint[:priority_index])
          issue.assigned_to = users.fetch(blueprint[:assignee])
          issue.category = categories.fetch(blueprint[:category])
          issue.fixed_version = versions_by_name.fetch(blueprint[:version])
          issue.start_date = Date.today + blueprint[:start_offset]
          issue.due_date = Date.today + blueprint[:due_offset]
          issue.done_ratio = blueprint[:done_ratio]
          issue.estimated_hours = blueprint[:estimated_hours]
          issue.description = blueprint[:description]
          issue.save!
          issue
        end
      end

      def ensure_relations!(issues)
        issues_by_subject = issues.index_by(&:subject)

        RELATIONS.each do |from_subject, to_subject, relation_type, delay|
          relation = IssueRelation.find_or_initialize_by(
            issue_from: issues_by_subject.fetch(from_subject),
            issue_to: issues_by_subject.fetch(to_subject),
            relation_type: relation_type
          )
          relation.delay = delay
          relation.save!
        end
      end

      def default_roles
        roles = Role.where(builtin: 0).order(:position).to_a

        {
          manager: roles.fetch(0),
          developer: roles.fetch(1),
          reporter: roles.fetch(2)
        }
      end

      def default_priorities
        Enumeration.where(type: 'IssuePriority')
      end

      def default_language
        Setting.default_language.presence || 'en'
      end
    end
  end
end