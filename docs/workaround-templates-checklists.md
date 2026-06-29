# Workarounds for Templates and Checklists

This guide provides step-by-step implementation instructions for the two workaround solutions recommended when using the Redmine alternative stack.

## Background

Two popular Redmine plugins are not compatible with Redmine 6.1 + Rails 7.2:
- **`redmine_issue_templates`** — Plugin load failure
- **`redmine_issue_todo_lists2`** — Database migration failure with ActiveRecord 7

This document explains how to implement low-tech, battle-tested workarounds to replace these plugins in your workflow.

---

## Workaround 1: Wiki-Based Template Library for Issues

### Problem Solved
Standardizing issue structure, filling out custom fields consistently, and avoiding missing required information.

### Implementation Steps

#### Step 1: Create a Template Library Page
1. Navigate to your project wiki.
2. Create a new page called `IssueTemplates` or `TemplateLibrary`.
3. Copy the template structure below and customize for your project.

#### Step 2: Define Issue Templates

Add a section for each issue type in your workflow. Example:

```markdown
h1. Issue Templates

h2. Bug Report

*Use this template when reporting a defect.*

**Severity**: [Select: Critical | High | Medium | Low]
**Component**: [Select from custom field options]
**Environment**: [OS, Browser, Redmine version, relevant software versions]

h3. Description
[Describe the bug clearly]

h3. Steps to Reproduce
# First step
# Second step
# ... etc

h3. Expected Result
[What should happen]

h3. Actual Result
[What actually happens]

h3. Attachments
[Screenshots, logs, or other supporting files]

---

h2. Feature Request

*Use this template when proposing a new feature.*

**Priority**: [Select: High | Medium | Low]
**Component**: [Select from custom field options]
**Target Release**: [Select from custom field options]

h3. Description
[Describe the feature and why it is needed]

h3. Acceptance Criteria
* [ ] Criterion 1
* [ ] Criterion 2
* [ ] Criterion 3

h3. Estimated Effort
[Optional: T-shirt size or story points]

---

h2. Task

*Use this template for internal work items.*

**Team**: [Select from custom field options]
**Assignee**: [Assigned to team member]

h3. Objective
[Clear statement of what needs to be done]

h3. Definition of Done
* [ ] Code written and reviewed
* [ ] Tests written and passing
* [ ] Documentation updated
* [ ] Deployed to staging

h3. Dependencies
[List any blocking tasks or external dependencies]
```

#### Step 3: Create a Custom Field to Enforce Consistency (Optional)

If your instance uses custom fields to track issue type:

1. Go to **Administration** > **Custom Fields** > **Issues**.
2. Create a custom field called `Issue Type` (or similar) with:
   - Type: List (dropdown)
   - Options: Bug, Feature Request, Task, Other
   - Required: Yes (for your main project)
3. Set it to appear in new issue forms and queries.

#### Step 4: Update the New Issue Form

1. Go to **Project Settings** > **Issue Categories** and ensure categories align with your template types.
2. Add a description to each category pointing teams to the template wiki page.

Example category description:
```
Bug Report — For defects and unexpected behavior.
See wiki template: /wiki/IssueTemplates#Bug-Report
```

#### Step 5: Workflow and Training

1. **Share the wiki page** with your team via email or project announcement.
2. **Link to templates** in project README or onboarding docs.
3. **Review new issues** in the first sprint to ensure template compliance; iterate on the template if needed.

### Verification Checklist

- [ ] Wiki page is created and accessible to all project members.
- [ ] Custom fields (if added) are visible in new issue forms.
- [ ] Team has been informed via email or announcement.
- [ ] First 5 issues follow the template structure.

### Advantages
✅ Zero plugin dependencies  
✅ Customizable per-project  
✅ Easy to version-control if wiki is Git-backed  
✅ Integrates with native custom fields  

### Limitations
⚠️ Relies on user discipline; no automatic enforcement  
⚠️ No form validation or auto-fill  
⚠️ Less polished UX than a dedicated plugin  

---

## Workaround 2: Parent/Child Issue Hierarchy for Checklists

### Problem Solved
Breaking down larger work items into trackable subtasks, visualizing progress, and managing dependencies.

### Implementation Steps

#### Step 1: Enable Parent/Child Issue Relationships

This is a native Redmine feature and is enabled by default. Verify:

1. Go to **Administration** > **Issue Statuses** and confirm you have statuses like New, In Progress, Closed.
2. Go to **Administration** > **Workflows** and ensure transitions allow moving child issues through statuses.

#### Step 2: Create a Parent Issue

1. Create a new issue with:
   - **Type**: Story or Task (depending on your workflow)
   - **Subject**: "User Authentication: Complete Implementation" (or similar)
   - **Description**: Include the overall objective and any shared context.
2. **Do not assign to a single person** if this is a multi-step task.

Example issue:
```
Subject: User Authentication: Complete Implementation
Type: Story
Description:

h2. Objective
Implement a complete login flow for the web app.

h2. Acceptance Criteria
* Login form is responsive and accessible
* Password validation is enforced
* 2FA option is available
* All related tests pass

h2. Deliverables
* Backend API endpoint for authentication
* Frontend login UI
* Database schema updates
```

#### Step 3: Create Child Issues

For each subtask in the checklist:

1. Click **Create a new issue** from the parent issue page (or click "New").
2. Set:
   - **Type**: Task (or Sub-task if your instance has this type)
   - **Parent**: (Link to the parent issue created in Step 2)
   - **Subject**: Single, actionable item (e.g., "Design login form UI")
   - **Assignee**: Team member responsible
   - **Estimated time**: (optional, for effort tracking)

Example child issues:
```
1. Design login form UI
   Parent: "User Authentication: Complete Implementation"
   Status: New
   Assignee: Designer
   
2. Implement password validation endpoint
   Parent: "User Authentication: Complete Implementation"
   Status: New
   Assignee: Backend Dev
   
3. Integrate 2FA provider
   Parent: "User Authentication: Complete Implementation"
   Status: New
   Assignee: Backend Dev
   
4. Write end-to-end tests
   Parent: "User Authentication: Complete Implementation"
   Status: New
   Assignee: QA Tester
```

#### Step 4: Track Progress

**View parent/child relationships:**

1. Open the parent issue; you will see all child issues listed below the description.
2. Create an **Issue Query** to filter by parent:
   - Go to **Queries** > **New Query**
   - Filter: **Parent** = (your parent issue ID)
   - Save this query as "My Active Checklists" for quick access.

**Visualize timeline (optional):**

1. Go to **Gantt** view and select the project.
2. Filter by **Parent** = your parent issue ID.
3. Redmine will show a visual timeline of when child tasks are completed.

#### Step 5: Update Status as Work Progresses

1. Change child issue status as work moves through your workflow (e.g., New → In Progress → Closed).
2. Parent issue status typically shows as "In Progress" once at least one child is started.
3. Parent issue closes when all children are closed.

#### Step 6: Integration with Recurring Tasks

If you use the **`periodictask`** plugin (installed by default):

1. Create a parent issue as a template.
2. Configure `periodictask` to generate a clone of this parent issue on a recurring schedule.
3. New child issues will be generated automatically with each recurring parent.

Example periodictask setup:
```
Task Name: "Weekly Sprint Planning"
Issue: "Sprint Planning Template" (parent with predefined children)
Frequency: Weekly (every Monday)
Duration: 52 weeks
```

### Verification Checklist

- [ ] Parent issue is created with clear objective and acceptance criteria.
- [ ] At least 3 child issues are created and linked to the parent.
- [ ] Each child issue is assigned to a team member.
- [ ] Parent/child relationship is visible in the issue view.
- [ ] Team has access to the parent/child query or Gantt view.

### Advantages
✅ Native Redmine feature; no plugin needed  
✅ Integrates with existing workflows and permissions  
✅ Works with `periodictask` for recurring checklists  
✅ Scales to complex multi-phase projects  
✅ Supports effort estimation and timeline visualization  

### Limitations
⚠️ No inline checklist UI (requires clicking to see children)  
⚠️ Heavier overhead for simple task lists  
⚠️ Requires setup per checklist; not as lightweight as a native checklist plugin  

---

## Troubleshooting

### Issue: Child issues are not showing under parent

**Solution**: Verify that:
1. You set the **Parent** field when creating the child issue.
2. The parent issue exists and is visible to you.
3. Your role has permission to see child issues (check **Administration** > **Roles**).

### Issue: I cannot see the parent/child query

**Solution**:
1. Go to **Queries** > **My Queries**.
2. Create a new query and add a filter for **Parent** = (your parent issue ID).
3. Save and bookmark the query for future use.

### Issue: I want inline checklists (not parent/child)

**Solution**: Consider upgrading to a commercial alternative:
- **`redmine_checklists`** from [RedmineUP](https://www.redmineup.com/pages/plugins/checklists) provides inline checkbox UI and is compatible with Redmine 6.1 + Rails 7.2.
- Integrates with `periodictask` for recurring checklist templates.

---

## Next Steps

1. Choose which workaround fits your team's workflow (or use both).
2. Implement the template library wiki page with your issue types.
3. Create 1-2 example parent issues with child tasks to test the hierarchy.
4. Train your team on the workflow in your next retrospective or standup.
5. Document your team's specific templates and checklist patterns in the wiki.

For further questions, refer to:
- **Free Plugin Matrix**: [docs/free-plugin-matrix.md](./free-plugin-matrix.md)
- **Sandbox Setup**: [docs/sandbox-setup.md](./sandbox-setup.md)
