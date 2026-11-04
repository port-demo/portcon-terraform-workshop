# Step 1 · Explore the seeded catalog (5 min)

Your org already has the mock data. Nothing to build yet.

1. Open **Catalog → Terraform Module**. You should see 4 modules:

   | Module | Owning team | Needs approval |
   |---|---|---|
   | rds-postgres | Data Platform | yes |
   | elasticache-redis | Data Platform | no |
   | s3-bucket | Cloud Platform | no |
   | sqs-queue | Cloud Platform | no |

2. Click **s3-bucket**. Read the **Description** (it ends with a `### Guardrails` list) and the **Inputs** (bucket_name, versioning, block_public_access, encryption). These are the rules the agents will follow.
3. Open **Catalog → Service** and click **billing**. Note its team. The owning team decides who approves.
4. Open **Catalog → Environment**: `staging`, `test`, `production`.

**Expected:** 4 modules, a few services with teams, 3 environments.

**Ask Port AI (optional, 30 seconds):** paste
```
Which Terraform modules are in the catalog, who owns each one, and which need approval?
```
You get a short table like the one above.
