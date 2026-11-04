# Step 5 · Run it: three requests (12 min)

Open **Self-service → Request Infra → Terraform PR** (or the **Request infra** card on *My Infra (Developer)*). Submit all three now and watch them in parallel. Each takes about 1 minute to reach a decision.

## Request A: auto-approved (no human needed)
| Field | Value |
|---|---|
| What do you need? | `An S3 bucket to store monthly invoice CSV exports for the billing service. Keep files for 90 days.` |
| Service | billing |
| Environment | staging |
| Data sensitivity | internal |

**Expected:**
- About 1 minute: status `approved`, approver **Port rules (auto)**, approval mode `auto`.
- 1–3 minutes later: status `pr_opened` with a PR link. Open it and see the inputs table, assumptions and guardrail checklist.

Reference run: 2m17s, PR #13.

## Request B: needs the owning team (production)
| Field | Value |
|---|---|
| What do you need? | `A small Postgres database for the payments API to store payment transaction history.` |
| Service | sample-payments-api |
| Environment | production |
| Data sensitivity | internal |

**Expected:**
- About 1 minute: status `awaiting_approval`. *Waiting on* says "Module owning team approval", because `rds-postgres` requires approval and the environment is production.
- Open the run (Workflows → Runs) or the **Approvals waiting** table on the platform dashboard. You see the plan (Multi-AZ on, encryption on) and the guardrail result.
- Type a reason, e.g. `Multi-AZ and encryption match the prod profile.`, and click **Approve**.
- 1–3 minutes later: `pr_opened` with a PR link. Approval mode is `human` and you are the approver.

Reference run: 3m01s including the approval, PR #14.

## Request C: blocked by a guardrail
| Field | Value |
|---|---|
| What do you need? | `A PUBLIC S3 bucket (public read, block public access off) to share customer invoice PDFs with partners.` |
| Service | billing |
| Environment | staging |
| Data sensitivity | confidential |

**Expected:**
- About 1 minute: the guardrail check fails. The planner kept your unsafe value on purpose, and the checker caught it: `❌ block_public_access must be true unless data_sensitivity is public` plus a "To fix" line.
- Core build (Step 4): status `rejected` with that reason, shown under **Needs my attention**.
- Full reference build: it waits for an exception decision. Click **Reject** with a reason, e.g. `Use a private bucket and presigned URLs.`

Reference run: 1m52s.

**Try it:** click ⚡ **Request Infra** on the rejected row. The form opens pre-filled from the rejected request. Change it to a private bucket and resubmit.

## Optional: start it from Port AI chat (not rehearsed, so try it before the session)
Paste:
```
I need a Redis cache for the checkout service in staging, internal data. Use the Request Infra workflow.
```
Port AI fills the same form and starts the same workflow.
