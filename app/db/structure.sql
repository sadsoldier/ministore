CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "username" varchar, "password_digest" varchar, "is_admin" boolean, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);

CREATE TABLE IF NOT EXISTS "documents" (
    "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    "name" varchar,
    "created_at" datetime(6) NOT NULL,
    "updated_at" datetime(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS "active_storage_blobs" (
    "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, 
    "key" varchar NOT NULL, 
    "filename" varchar NOT NULL, 
    "content_type" varchar, 
    "metadata" text, 
    "byte_size" bigint NOT NULL, 
    "checksum" varchar NOT NULL, 
    "created_at" datetime NOT NULL
);

CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key");

CREATE TABLE IF NOT EXISTS "active_storage_attachments" (
    "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, 
    "name" varchar NOT NULL, 
    "record_type" varchar NOT NULL, 
    "record_id" integer NOT NULL, 
    "blob_id" integer NOT NULL, 
    "created_at" datetime NOT NULL, 
    CONSTRAINT "fk_rails_c3b3935057"
        FOREIGN KEY ("blob_id")
        REFERENCES "active_storage_blobs" ("id")
);

CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id");
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id");
INSERT INTO "schema_migrations" (version) VALUES
('20190819124602'),
('20191110222512'),
('20191120121206');


