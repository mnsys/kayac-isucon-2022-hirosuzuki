CREATE INDEX playlist_ulid ON playlist (ulid);
CREATE INDEX playlist_public_created_at ON playlist (is_public, created_at DESC);
CREATE INDEX song_ulid ON song (ulid);
CREATE INDEX playlist_favorite_index02 ON playlist_favorite (favorite_user_account, created_at DESC);
