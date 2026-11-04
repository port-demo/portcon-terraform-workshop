# RUNBOOK · 101 | Turn a plain-language request into a governed Terraform PR
PortCon SF · Mon Nov 17 2026 · 13:00–15:00 SF time (PST) · Salon
Deck: `slides/governed_tf_pr_deck.pptx` · Participant guide: `guide/00`–`06` · Demo org: org_VR1NWCggZiyGVPsr · Repo: port-demo/portcon-terraform-workshop

## T-60 min: facilitator checklist (see instructor-setup.md)
- [ ] Every participant org has the `CURSOR_API_KEY` secret and the base env: 4 modules, services with teams, 3 environments, the Start here page.
- [ ] In the demo org, open these tabs:
  - Start here
  - My Infra (Developer)
  - Infra Governance (Platform Engineer)
  - Workflows → Request Infra → Terraform PR (canvas)
  - GitHub PR #13, #14, #5
- [ ] Do one warm-up Request A in the demo org. Expect pr_opened in about 2.5 min. If it fails, check the CURSOR_API_KEY secret first.
- [ ] Projector: zoom 125%. Keep the QR slide ready.

## Minute by minute
| Time (PST) | Min | What happens | Facilitator does | Participants do | Checkpoint |
|---|---|---|---|---|---|
| 13:00 | 5 | Welcome, logins | Slide 1. "Speed for safe changes, control for risky ones." Helpers hand out org logins | Log in and open **Start here** | Everyone sees Start here |
| 13:05 | 10 | **The pain** | Slides 1–2. A dev needs a database → a ticket → the platform engineer translates it into Terraform → review → 3–5 days. Every PR gets the same scrutiny, a staging bucket and a prod DB alike. | Listen | — |
| 13:15 | 5 | **The why** | Slides 3–4. Govern the *request*, not just the code. Safe changes go straight through. Risky ones go to the right human with the plan and the guardrail result in hand. | Listen | — |
| 13:20 | 10 | **Live demo, the end state** | Slide 5. Submit Request A (S3, staging) and Request B (Postgres, prod) from *My Infra*. While they run (about 1 min), show the canvas. B → *Approvals waiting* → Approve with a reason. Show PR #13 and #14 bodies. Finish on *Infra Governance*. | Watch | A shows pr_opened by about 13:23, B by about 13:26 |
| 13:30 | 5 | Step 1 · Explore | "Open 01-explore. Find the s3-bucket guardrails." | 01-explore.md | Can name 2 s3-bucket guardrails |
| 13:35 | 8 | Step 2 · Blueprint | Read Prompt 1 aloud | Paste Prompt 1 into Port AI | `infra_request` exists with the waiting_on calc |
| 13:43 | 12 | Step 3 · Skills and agents | Explain: the skill is the knowledge, the agent is the worker. Point out "keep unsafe values so the checker can catch them". | Prompts 2 and 3, then "Try it" | The planner answers with a module and inputs |
| 13:55 | 15 | Step 4 · Workflow | Show the 3 canvas checks | Prompt 4, then check the canvas | 12 nodes. Fallback: helper loads the reference JSON |
| 14:10 | 12 | Step 5 · Run it | Walk the room. Help people find the input node | Requests A, B, C | A auto, B approved by you, C blocked with a reason |
| 14:22 | 13 | Step 6 · Dashboards and bonus | Show the ⚡ row actions (Resubmit, Retry PR, Assign owner) | Prompt 5, then Bonus A or B | Own requests appear in *My requests* |
| 14:35 | 10 | Review together | Open the demo org *Infra Governance*: Exceptions granted (#5), Where guardrails fail, Modules with gaps (elasticache-redis: no requests). Ask: "What would you approve automatically in your org?" | Share | — |
| 14:45 | 10 | Summary, Q&A, QR | Recap: plain language → module → 2 guardrail checks → the right human only when needed → PR, every decision recorded. QR slide | Scan the QR | — |
| 14:55 | 5 | Buffer | — | — | — |

## Contingencies
| Symptom | Likely cause | Fix (≤ 2 min) |
|---|---|---|
| Port AI builds a different blueprint or workflow | Prompt drift | Retry once, then load the reference JSON from `guide/reference/` (Builder → Edit JSON) |
| Run stops at `open_pr` with an auth error | No `CURSOR_API_KEY` in the org | Keep going; show the PR in the demo org. Helper adds the secret |
| Request stuck in `pr_opening` > 6 min | Cursor agent slow | ⚡ *Mark stuck PR as failed*, then ⚡ *Retry PR* |
| Participant can't click Approve | Not in the owning team and not Admin | Admin is the fallback responder. Make them Admin, or approve from the facilitator account |
| Request A asks for approval | They picked production or confidential | That's correct behaviour. Use the rule as a teaching moment |
| Wi-Fi down | — | Run the demo from the recorded opening video plus PR #13 and #14 screenshots |

## Reference timings (demo org, Nov 4 2026)
| Path | Time |
|---|---|
| Auto staging S3 | 2m17s |
| Owner-approved prod RDS | 3m01s (including the approval) |
| Exception reject | 1m52s |
| No module, manual | 1m16s |
| No module, delegate | 3m15s |

Every run reaches its decision in about 1 minute. See tests/e2e-2026-11-04.md.
