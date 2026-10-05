# Project Map

## Purpose
Riftbound TCG app for the learner and their friends.

## Requirements
- View all Riftbound cards.
- View which cards each friend owns.
- Card data sourced from the riftcodex API.

## Components
Implemented (verified in repo):
- Postgres 16 via docker-compose.yml (host port 5433), credentials from .env.
- Migrations (goose format): migrations/00001_create_sets.sql (sets), migrations/00002_create_cards.sql (cards, FK set_code -> sets.code).
- Importer: cmd/importer/main.go — connects to Postgres with pgx pool via DATABASE_URL and pings. No riftcodex fetch yet.

Chosen by learner, not yet built:
- Importer design (confirmed 2026-10-05): optional set flag (none = all sets); per set, upsert set row then page through /cards?set_id=X (size 100) and upsert cards with ON CONFLICT DO UPDATE; partial runs recovered by re-running. Structure (confirmed): main.go run loop; GET /sets each run validates flag + selects sets + upserts all sets before cards; root ctx (signal.NotifyContext) with per-call timeouts; helper files in cmd/importer (package main).
- Go backend API.
- Angular frontend with TypeScript, RxJS, NgRx stores.

## Main Flow
riftcodex API --(fetch: not built)--> importer (cmd/importer) --(upsert: ?)--> Postgres
Postgres <-- Go API (not built) <--(HTTP: ?)-- Angular (not built)

## Data and Trust Boundaries
- Tables: sets, cards. No users or ownership tables yet.
- User identity / auth for friends: unknown.

## Build and Deployment
- `docker compose up` for Postgres (reads .env).
- Migrations use goose annotations; how they're run is not verified.

## Unknowns
- Ownership data model and user identity.
- API shape; frontend structure.
- Hosting/deployment.
