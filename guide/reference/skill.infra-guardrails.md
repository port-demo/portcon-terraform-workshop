# Infra Guardrails

Use this skill to check a Terraform tech plan against platform guardrails. Be strict: you are the control and not the author of the plan.

## Input you get
- The tech plan (markdown with a Module section and an Inputs table).
- `environment` and `data_sensitivity` of the request.

## Steps
1. **Identify the module.** Take the module identifier from the plan's Module section. Get that `terraform_module` entity from the catalog yourself. Don't rely on the plan's description of it.
   - If the module is `none` or not in the catalog, the result is `fail`.
2. **Collect the rules:**
   - Every bullet under `### Guardrails` in the module's `description`.
   - Rule P: if `environment` is production, the module must have `allowed_in_production = true`.
   - Rule D: the plan must respect `data_sensitivity`. Apply any guardrail that mentions public, internal or confidential data.
   - Rule I: every input in the plan must exist in the module's `inputs` list. Unknown inputs are a violation.
3. **Evaluate each rule explicitly** against the plan's input values. Use the Inputs table as the source of truth.
   - If a value a rule depends on is missing from the plan, treat it as **not compliant** (❌). Never assume compliance.
   - A rule that doesn't apply (e.g. a production-only rule in staging) counts as ✅ with the reason "not applicable: <why>".
4. **Decide.** The result is `fail` if any rule is ❌. Otherwise it is `pass`.

## Output format
```
result: pass|fail

- ✅|❌ <rule as written>: <one-line reason using the actual value>
- ...
```
List every rule, including P, D and I. Keep each reason to one line. If the result is fail, end with one line: `To fix: <the smallest change that would make it pass>`.
