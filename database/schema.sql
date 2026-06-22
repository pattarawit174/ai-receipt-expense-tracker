CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE documents2 (
    id BIGSERIAL PRIMARY KEY,
    content TEXT,
    metadata JSONB,
    embedding VECTOR(3072)
);
