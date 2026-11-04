# Step 6 · Dashboards and bonus paths (13 min)

## Prompt 5 · two dashboards (paste into Port AI)
```
Create two dashboard pages under the workshop folder.

1) my_infra_developer, title "My Infra (Developer)":
- workflow card "Request infra" for request_infra_to_terraform_pr
- markdown "What happens next": a short diagram of the paths (auto-approved, owning team approves, exception, no module fits)
- table "Before you ask: available modules": terraform_module; columns title, description, requires_approval, owning_team
- table "My requests": infra_request where requester = current user; columns title, status, waiting_on, days_waiting, pr_url, environment
- table "Needs my attention": infra_request where requester = current user and status = rejected; columns title, decision_reason, terraform_module, environment

2) infra_governance_platform_engineer, title "Infra Governance (Platform Engineer)":
- number charts: "Waiting on a person" (status awaiting_approval), "Exceptions granted (30d)" (approval_mode exception, created last month), "Stuck PRs" (status pr_failed)
- table "Approvals waiting": status = awaiting_approval; columns title, waiting_on, days_waiting, service, environment, terraform_module
- table "Failed or stuck PRs": status = pr_failed
- table "Exceptions granted": approval_mode = exception; columns title, approver, decision_reason, pr_url
- bar chart "Where guardrails fail": infra_request with policy_check = fail, grouped by terraform_module
- table "Modules with gaps": terraform_module with no owning_team or requests_30d = 0
```
**Expected (about 2 minutes):** two pages in the sidebar. Your three requests from Step 5 appear in *My requests* and in the platform numbers.

**Make every widget actionable (the point of the dashboards):** each table row has ⚡ actions. Ask Port AI to add them:
- On a rejected request: *Request Infra* (resubmit, pre-filled).
- On a pr_failed request: *Retry PR*. On a PR stuck in pr_opening: *Mark stuck PR as failed*.
- On a module: *Assign owner*.

Approvals are answered from the run page, which opens from the request.

## Bonus A · Exceptions instead of hard rejects (5 min)
Real platform teams grant exceptions: "staging only, until Dec 1". Prompt:
```
In workflow request_infra_to_terraform_pr, when guardrails fail and a module was chosen, don't reject right away.
Add an input node exception_approval (buttons "Approve exception" and Reject, required Reason; responders role Admin and Member).
Approve: set approval_mode exception, status approved, approver = responder, decision_reason = reason, then go to open_pr.
Reject: go to reject_request with the reason.
```
Re-run Request C and click **Approve exception**. It appears under **Exceptions granted** on the platform dashboard.

## Bonus B · No module fits (5 min)
Prompt:
```
In workflow request_infra_to_terraform_pr, when the planner's module is "none", go to an input node platform_decision
with buttons "Do it manually (platform team)" and "Delegate to coding agent", required Reason.
Manual: set status manual_platform. Delegate: run a Cursor agent that drafts a new reusable module under modules/
plus its usage in envs/<environment>/, opens a PR titled "[new module][needs platform review] ...",
and set status pr_opened with the PR link.
```
Test it with `A Kafka topic for billing events so other services can subscribe to invoice updates.` (billing, staging, internal).
Choose **Do it manually**. The status becomes `manual_platform` in about 1 minute.

## What you built
Plain language in → an approved module, guardrails checked twice (planner and checker), the right human only when needed → a Terraform PR, with every decision recorded and visible on two dashboards.
