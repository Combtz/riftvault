-- +goose Up
CREATE TABLE cards (
    riftbound_id      TEXT PRIMARY KEY,
    riftcodex_id      TEXT NOT NULL,
    set_code          TEXT NOT NULL REFERENCES sets(code),
    name              TEXT NOT NULL,
    collector_number  INTEGER NOT NULL,
    card_type         TEXT NOT NULL,
    supertype         TEXT,
    rarity            TEXT NOT NULL,
    domains           TEXT[] NOT NULL DEFAULT '{}',
    energy            INTEGER,
    might             INTEGER,
    power             INTEGER,
    text_plain        TEXT NOT NULL DEFAULT '',
    text_rich         TEXT NOT NULL DEFAULT '',
    flavour_text      TEXT,
    image_url         TEXT NOT NULL,
    artist            TEXT,
    orientation       TEXT,
    alternate_art     BOOLEAN NOT NULL DEFAULT false,
    overnumbered      BOOLEAN NOT NULL DEFAULT false,
    signature         BOOLEAN NOT NULL DEFAULT false,
    tcgplayer_id      TEXT,
    source_updated_on TIMESTAMPTZ,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX cards_set_code_idx ON cards (set_code);

-- +goose Down
DROP TABLE cards;