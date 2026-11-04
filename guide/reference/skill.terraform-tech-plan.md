# Terraform Tech Plan

Use this skill to turn an infra request into a Terraform tech plan. Use only catalog data and never invent modules, inputs or teams.

## Input you get
- `request_text`: what the developer asked for, in plain language.
- `service`: the `service` entity identifier.
- `environment`: the `environment` entity identifier (e.g. `staging`, `production`).
- `data_sensitivity`: `public`, `internal` or `confidential`.
- Optionally an `infra_request` identifier.

## Steps
1. **Read the request.** Extract what resource is needed, what for, and any explicit settings (size, counts, names, flags).
2. **Read the service.** Get the `service` entity and its owning team (`$team` or owner relation). Note the environment.
3. **List the modules.** List all `terraform_module` entities. Read each one's `description` (including `### Guardrails`), `inputs`, `allowed_in_production`, `requires_approval`, `cost_tier` and `owning_team`.
4. **Pick exactly one module.** Choose the single best fit for the request and explain why in one or two sentences, and why the closest alternative doesn't fit.
   - If no module fits, stop and say so: `No catalog module fits this request.` Add a one-line reason. Do not make one up.
   - If `environment` is production and the module has `allowed_in_production = false`, say so in the plan. The guardrail check will fail it.
5. **Map the request to inputs.** For every input in the module's `inputs` list:
   - If the request states a value, use it. The source is `request`.
   - If the request is silent, use the module's default. The source is `default`.
   - If several values are reasonable, prefer the more secure or resilient one: encryption on, public access blocked, versioning on, and in production multi-AZ / 2+ nodes / DLQ. In that case the source is `default (secure)`.
   - If a required input has no default (e.g. `bucket_name`), derive it from the service name, e.g. `<service>-<purpose>`. The source is `derived`.
   - Every value not taken from the request must be listed under Assumptions.
6. **Consider the context.** Make the values consistent with `environment` and `data_sensitivity` and with the module's guardrails. Don't knowingly propose a value that breaks a guardrail.
7. **Write the plan** in the format below.

## Output format (markdown)
```
## Summary
<2-3 sentences: what will be created, for which service, in which environment>

## Module
`<module identifier>`: <why it is the best fit>

## Inputs
| Input | Value | Source |
|---|---|---|
| <name> | <value> | request / default / default (secure) / derived |

## Assumptions
- <every value not stated in the request, and any interpretation you made>

## Cost tier
<module cost_tier>

## Owning team
Module owner: <module owning_team>. Service team: <service team or "unknown">
```
If no module fits, output only `## Summary` with the reason and `## Module` set to `none`.
