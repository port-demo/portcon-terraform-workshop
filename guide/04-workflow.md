# Step 4 · The workflow (15 min)

One self-service workflow, `request_infra_to_terraform_pr`. In this step you build the core path: request → plan → guardrails → approval → PR. Step 6 adds the exception and no-module paths as a bonus.

## Prompt 4 (paste into Port AI)
```
Create a workflow with identifier request_infra_to_terraform_pr, title "Request Infra → Terraform PR",
category "Infra self-service", shown in the self-service hub.

Trigger (self-service form "Request Infra"):
- request_text (multi-line, required, title "What do you need?")
- service (entity of blueprint service, required)
- environment (entity of blueprint environment, required)
- data_sensitivity (enum public, internal, confidential, required, default internal)
- module (entity of blueprint terraform_module, optional)

Nodes, in order:
1. log_request: create an infra_request entity with request_text, requester = the triggering user's email,
   data_sensitivity, relations service and environment, status "planned".
2. draft_plan: AI agent node running agent infra_planner. Pass it request_text, service, environment,
   data_sensitivity and module. Output schema: plan (markdown), module (string, "none" if nothing fits).
3. check_guardrails: AI agent node running agent guardrails_checker on the plan. Output schema:
   result (enum pass, fail), details (markdown).
4. save_plan: update the infra_request with tech_plan, policy_check = result, policy_check_details = details,
   and relation terraform_module = module when it is not "none".
5. guardrails_ok: condition. If result is pass go to needs_approval, otherwise go to reject_request.
6. needs_approval: condition. Needs a person when environment is production, OR data_sensitivity is confidential,
   OR the module's requires_approval is true. Otherwise go to auto_approve.
7. auto_approve: update the entity: status approved, approval_mode auto, approver "Port rules (auto)",
   decision_reason "Auto-approved: passed guardrails, no approval rule matched". Then go to open_pr.
8. owner_approval: input node with buttons Approve and Reject, a required Reason field, and the plan and
   guardrail result shown read-only. Responders: members of the module's owning team, plus role Admin.
   Approve: status approved, approval_mode human, approver = responder, decision_reason = reason, then open_pr.
   Reject: status rejected, approver = responder, decision_reason = reason.
9. reject_request: update the entity: status rejected, decision_reason = the failed guardrail lines.
10. open_pr: Cursor agent node (secret CURSOR_API_KEY) on repo port-demo/portcon-terraform-workshop, branch
    infra/<request id>. Prompt: write a Terraform file under envs/<environment>/ that calls the chosen module with
    the planned inputs, and open a PR whose body has the summary, inputs table, assumptions, guardrail result and
    approval. Then update the entity: status pr_opened, pr_url = the PR link.
```

**Expected (2–4 minutes):** Port AI shows a workflow with about 12 nodes. Open **Workflows → Request Infra → Terraform PR** and check the canvas reads left to right like the list above.

**Check these 3 things in the canvas (most common mistakes):**
1. `guardrails_ok` has two exits (pass and fail).
2. `owner_approval` has both an Approve and a Reject exit.
3. `open_pr` uses the secret `CURSOR_API_KEY`. Never paste the key itself.

**Fallback (if the canvas looks wrong after one retry):** ask your helper to load the reference workflow `reference/request_infra_to_terraform_pr.workflow.json` (25 nodes, all paths) into your org. Then go to Step 5.

> **No PR in your org?** If `CURSOR_API_KEY` isn't set in your org, the run stops at `open_pr` with an auth error. Everything before it (plan, guardrails, approval, entity updates) still works. The facilitator shows the PR part on the big screen.
