# Step 2 · Create the request blueprint (8 min)

Every request becomes an `infra_request` entity. It holds the plan, the guardrail result, who approved it and the PR link.

## Prompt 1 (paste into Port AI)
```
Create a blueprint with identifier infra_request, title "Infra Request", icon Terraform.
Properties:
- request_text (string, title "Request")
- requester (string, format user)
- tech_plan (string, format markdown)
- policy_check (string enum: pass, fail, not_run; colors green, red, lightGray)
- policy_check_details (string, format markdown)
- status (string enum: needs_info, planned, awaiting_approval, approved, rejected, pr_opening, pr_opened, pr_failed, manual_platform)
- approval_mode (string enum: auto, human, exception)
- approver (string)
- decision_reason (string, format multi-line)
- approval_reason (array of strings)
- data_sensitivity (string enum: public, internal, confidential)
- pr_url (string, format url)
- pr_requested_at (string, format date-time)
- pr_deadline (string, format timer)
Relations (single, not required): service -> service, environment -> environment, terraform_module -> terraform_module.
Mirror properties: service_team = service.$team, module_owning_team = terraform_module.owning_team.
Calculation property waiting_on (string): "Module owning team approval" when status is awaiting_approval,
"Platform team: building it manually" when manual_platform, "Coding agent is opening the PR" when pr_opening,
"Platform team: Retry PR" when pr_failed, "PR review and merge" when pr_opened, "You: fix and resubmit" when rejected,
otherwise the status.
```

**Expected (about 1 minute):** Port AI shows the blueprint it created. Open **Builder → Infra Request** and check you see 14 properties, 3 relations, 2 mirror properties and the `waiting_on` calculation.

**Check:** the `status` enum has all 9 values. The workflow writes them.

**Fallback:** ask your helper for `reference/infra_request.blueprint.json` and paste it in **Builder → + Blueprint → Edit JSON**.
