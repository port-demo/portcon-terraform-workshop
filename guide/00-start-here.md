# 101 | Turn a plain-language request into a governed Terraform PR

PortCon SF · Mon Nov 17, 2026 · 13:00–15:00 (SF time) · Salon · Matar Peles
Guide v1.0 (Nov 4, 2026). It matches the reference build in the instructor org (workflow `request_infra_to_terraform_pr`).

**Level:** 101 · **Hands-on:** about 65 minutes · **You need:** the workshop Port org you were given and Port AI · **Install:** nothing · **Data:** mock services and Terraform modules.

## The pain
- A developer needs a database. They open a ticket and wait days.
- A platform engineer translates the ticket by hand into a module, inputs, tags and sizing.
- Guardrails (encryption, no public buckets, production sizing) are checked only if the reviewer remembers to check.
- Nobody can answer "who is this waiting on?" or "how many exceptions did we grant this month?"

## What you'll build
A developer writes **one sentence**. Port does the rest:

```
Request (one sentence + service + environment + data sensitivity)
  -> Infra Planner agent: picks an approved Terraform module, fills its inputs
  -> Guardrails Checker agent: checks the plan independently, pass or fail
  -> pass + low risk        -> auto-approved by "Port rules (auto)"
  -> pass + prod/confidential/module rule -> owning team approves
  -> fail, module exists    -> platform grants an exception or rejects with a reason
  -> fail, no module fits   -> platform does it manually or delegates a new module to an agent
  -> approved               -> a coding agent opens the Terraform PR on GitHub
```
Every step is written to an `infra_request` entity, so two dashboards show it: one for developers, one for the platform team.

## Steps and timing
| # | Step | File | Time |
|---|---|---|---|
| 1 | Explore the seeded catalog | 01-explore.md | 5 min |
| 2 | Create the request blueprint (Prompt 1) | 02-blueprint.md | 8 min |
| 3 | Create the two skills and two agents (Prompts 2 and 3) | 03-skills-and-agents.md | 12 min |
| 4 | Create the workflow (Prompt 4) | 04-workflow.md | 15 min |
| 5 | Run it: three requests | 05-run-it.md | 12 min |
| 6 | Dashboards (Prompt 5) and bonus paths | 06-dashboards-and-bonus.md | 13 min |

Stuck at any step? Every step has a **Fallback** that loads the finished piece, so you can keep going. Raise your hand: helpers have the reference build open.

## Names you will use (keep them exact, later steps depend on them)
| Object | Identifier |
|---|---|
| Blueprint | `infra_request` |
| Skills | `terraform-tech-plan`, `infra-guardrails` |
| AI agents | `infra_planner`, `guardrails_checker` |
| Workflow | `request_infra_to_terraform_pr` |
| Dashboards | `my_infra_developer`, `infra_governance_platform_engineer` |
