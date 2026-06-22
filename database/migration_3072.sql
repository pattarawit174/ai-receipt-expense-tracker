DROP TABLE IF EXISTS documents2 CASCADE;
DROP FUNCTION IF EXISTS match_documents(vector, float, int);
DROP FUNCTION IF EXISTS match_documents(vector, float, int, jsonb);

CREATE TABLE documents2 (
    id BIGSERIAL PRIMARY KEY,
    content TEXT,
    metadata JSONB,
    embedding VECTOR(3072)
);

CREATE OR REPLACE FUNCTION match_documents (
    query_embedding VECTOR(3072),
    match_threshold FLOAT DEFAULT 0.0,
    match_count INT DEFAULT 10,
    filter JSONB DEFAULT '{}'
)
RETURNS TABLE (
    id BIGINT,
    content TEXT,
    metadata JSONB,
    similarity FLOAT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        documents2.id,
        documents2.content,
        documents2.metadata,
        1 - (documents2.embedding <=> query_embedding) AS similarity
    FROM documents2
    WHERE 1 - (documents2.embedding <=> query_embedding) > match_threshold
      AND documents2.metadata @> filter
    ORDER BY similarity DESC
    LIMIT match_count;
END;
$$;
