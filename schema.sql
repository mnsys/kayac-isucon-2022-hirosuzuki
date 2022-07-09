CREATE INDEX playlist_ulid ON playlist (ulid);
CREATE INDEX playlist_public_created_at ON playlist (is_public, created_at DESC);
CREATE INDEX song_ulid ON song (ulid);
CREATE INDEX playlist_favorite_index02 ON playlist_favorite (favorite_user_account, created_at DESC);
ALTER TABLE playlist ADD favorite_count int INVISIBLE;
CREATE INDEX playlist_favorite_count ON playlist (favorite_count);
CREATE INDEX playlist_index03 ON playlist (user_account, created_at DESC);
ALTER TABLE playlist MODIFY favorite_count int DEFAULT 0;
ALTER TABLE playlist ADD song_count int DEFAULT 0;
