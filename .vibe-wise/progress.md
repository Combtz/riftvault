# Learning Progress

## Pending decision
- Decision: Importer approach (riftcodex -> Postgres).
- Stage: Design + code structure confirmed 2026-10-05. No AI code authorized. Next: learner writes code; Build checkpoint on Go types for API JSON.
- Learner's decisions (2026-10-05):
  - Fetch per set; key rows by primary key.
  - Re-runs overwrite existing rows (INSERT ... ON CONFLICT DO UPDATE).
  - CLI flag selects one set; no flag imports all sets.
  - Run on initial DB creation and per new set release.
  - Partial import after a crash is acceptable (re-run recovers).
- Proposed additions by AI (confirmed with design 2026-10-05): set row upserted before its cards; page through /cards?set_id=X&page=N&size=100 until pages exhausted; Go structs mirroring nested JSON then flattened to columns; published_on datetime -> DATE; updated_at = now() on update.
- Code structure (Build checkpoint in progress, 2026-10-05): learner proposed main.go as the run loop calling functions in extra files; flow = read CLI flag -> enum map flag->SetID -> fetch from API -> transform JSON to types -> SQL upsert. Learner revised: fetch GET /sets and validate the flag against it (replaces hardcoded map); root context with per-call child timeouts for API/DB calls. Learner floated a separate sets-update flag; after AI challenge (FK on new-set cards, /sets already in memory) learner decided: upsert sets every run from the in-memory /sets data, no extra flag. Learner's rationale: saves another call; riftcodex may not stay maintained. Code structure confirmed 2026-10-05 incl. proposed additions: upsert all /sets results before any cards; page loop page=1..pages size=100 with per-page timeout; root ctx via signal.NotifyContext; extra files in cmd/importer as package main.
- Concept explained: context trees (WithTimeout child of root, cancel on parent).
- Concept explained: Postgres upsert (ON CONFLICT DO NOTHING / DO UPDATE, EXCLUDED), idempotency.

## Verified external facts
- riftcodex API (api.riftcodex.com, OpenAPI 0.2.0, checked 2026-10-05): GET /sets and GET /cards are paginated ({items,total,page,size,pages}), size max 100. /cards accepts set_id filter (case-insensitive). 8 sets currently. Card JSON is nested (attributes, classification, text, set, media, metadata).

## History
- Flagged trailing comma in migrations/00001_create_sets.sql: fixed (verified 2026-10-05).
