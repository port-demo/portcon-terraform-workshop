# Step 3 · Skills and agents (12 min)

Two agents, each with one skill. One plans, the other checks. The checker never trusts the planner.

## Prompt 2 · the two skills (paste into Port AI)
```
Create two skills.

1) identifier terraform-tech-plan, title "Terraform Tech Plan". Instructions: turn an infra request
(request_text, service, environment, data_sensitivity) into a Terraform tech plan using only catalog data.
List all terraform_module entities and pick exactly one; if none fits, say "No catalog module fits this request"
and set the module to none. For every module input use the value from the request, else the module default,
preferring the secure option (encryption on, public access blocked, versioning on, multi-AZ in production).
Derive required inputs with no default from the service name. Keep any value the developer asked for, even if
unsafe, and list conflicts under "## Concerns". Output markdown with sections: Summary, Module, Inputs
(table: Input | Value | Source), Assumptions, Concerns, Cost tier, Owning team.

2) identifier infra-guardrails, title "Infra Guardrails". Instructions: check a Terraform tech plan. Read the
chosen terraform_module yourself. Check every rule in its "### Guardrails" list against the plan's actual
values, check allowed_in_production when the environment is production, and fail public access or missing
encryption when data_sensitivity is confidential. If the module is none, fail with "No catalog module fits".
Return result pass or fail and a markdown list with one line per rule: ✅ or ❌, the rule, and "To fix: ..." for failures.
```
**Expected:** two skills under **Catalog → Skill**.

## Prompt 3 · the two agents (paste into Port AI)
```
Create two AI agents, both read-only (tools: list, get, search, describe and load_skill only), execution mode Automatic.

1) identifier infra_planner, title "Infra Planner", skill terraform-tech-plan. Prompt: "You are the Infra Planner.
Always load the terraform-tech-plan skill first and follow it exactly. Use only terraform_module, service,
environment and _team entities. Never invent modules, inputs or teams. Keep every value the developer asked for,
even unsafe ones, and list conflicts under Concerns. Return the plan as your answer."

2) identifier guardrails_checker, title "Guardrails Checker", skill infra-guardrails. Prompt: "You are the
Guardrails Checker. Always load the infra-guardrails skill first and follow it exactly. You did not write this
plan; read the chosen terraform_module yourself and check each rule against the plan's actual values. Missing
values are not compliant. Return exactly pass or fail plus the rule-by-rule list."
```
**Expected:** two agents under **AI Agents**.

**Try it (1 min):** open **Infra Planner** and ask `Plan an S3 bucket for invoice exports for billing in staging with internal data`. You get a plan with module `s3-bucket` and an inputs table in about 30 seconds.

**Fallback:** the full skill and prompt text is in `reference/skill.*.md` and `reference/agent.*.prompt.md`. Paste them into the entity's fields.
