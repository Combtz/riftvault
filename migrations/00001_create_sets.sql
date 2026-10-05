-- +goose Up
CREATE TABLE sets (
    code TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    card_count INTEGER NOT NULL,
    published_on DATE,
    tcgplayer_id TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- +goose Down
DROP TABLE sets;
