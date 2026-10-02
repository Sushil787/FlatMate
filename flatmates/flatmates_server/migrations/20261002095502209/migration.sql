BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "away" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "away_flat_idx" ON "away" USING btree ("flatId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chore" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "name" text NOT NULL,
    "period" bigint NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "rotation" json NOT NULL,
    "rotationIndex" bigint NOT NULL,
    "archived" boolean NOT NULL
);

-- Indexes
CREATE INDEX "chore_flat_idx" ON "chore" USING btree ("flatId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_token" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "token" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "device_token_token_idx" ON "device_token" USING btree ("token");
CREATE INDEX "device_token_user_idx" ON "device_token" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "flat" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "timezone" text NOT NULL,
    "adminMateId" bigint,
    "inviteCode" text NOT NULL,
    "awayRule" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "flat_invite_code_idx" ON "flat" USING btree ("inviteCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "flat_event" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "title" text NOT NULL,
    "note" text,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "flat_event_flat_idx" ON "flat_event" USING btree ("flatId", "startsAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "grocery_item" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "name" text NOT NULL,
    "note" text,
    "addedByMateId" bigint NOT NULL,
    "boughtByMateId" bigint,
    "boughtAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "grocery_item_flat_idx" ON "grocery_item" USING btree ("flatId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mate" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "leftAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "mate_auth_user_idx" ON "mate" USING btree ("authUserId");
CREATE INDEX "mate_flat_idx" ON "mate" USING btree ("flatId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notice" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "text" text NOT NULL,
    "pinned" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notice_flat_idx" ON "notice" USING btree ("flatId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "swap_debt" (
    "id" bigserial PRIMARY KEY,
    "choreId" bigint NOT NULL,
    "debtorMateId" bigint NOT NULL,
    "creditorMateId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "swap_debt_chore_idx" ON "swap_debt" USING btree ("choreId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "turn" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "choreId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "coveringForMateId" bigint,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL,
    "doneAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "turn_chore_idx" ON "turn" USING btree ("choreId");
CREATE INDEX "turn_flat_time_idx" ON "turn" USING btree ("flatId", "startsAt");


--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261002095502209', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261002095502209', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
