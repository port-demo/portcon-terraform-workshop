# Instructor setup (base env for participant orgs)

**Must exist in every participant org before 13:00:**
- **Secret `CURSOR_API_KEY`.** The workflow and Retry PR reference it by name only. Without it, PRs fail at `open_pr`.
- **Blueprints:** terraform_module, service (with an owning team), environment (dev, staging, production), and _team.
- **4 terraform_module entities** (`reference/terraform_module.entities.json`), each with an owning team:
  - rds-postgres and elasticache-redis → data-platform
  - s3-bucket and sqs-queue → cloud-platform
- **The participant user is a member of** data-platform, cloud-platform and billing, or is Admin. Otherwise only Admin can answer approvals.
- **GitHub:** the Cursor agent can open branches and PRs in the target repo. Each org should point to its own repo or branch prefix to avoid collisions.
- **Pages:** Start here (workshop folder). The participants build the two dashboards.

**Not yet verified (do before the event):**
- The participant prompts (Prompts 1–5) have not been run end to end in a fresh copy of the base env (org_Jo2EHFMHtKOVGSL1). Everything was built and tested in org_VR1NWCggZiyGVPsr.
- Port AI chat as a trigger (05-run-it, optional section).

**Answers to likely questions:**
- **Why is the auto approver "Port rules (auto)"?** So every request records who or what approved it.
- **Why is approval_mode blank on reject, manual or delegate?** It only records *how* something was approved: auto, human or exception.
