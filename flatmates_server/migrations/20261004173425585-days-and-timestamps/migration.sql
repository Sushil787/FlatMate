BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "away" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "away" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "startDay" timestamp without time zone NOT NULL,
    "lastDay" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "away_flat_idx" ON "away" USING btree ("flatId");

--
-- ACTION DROP TABLE
--
DROP TABLE "chore" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chore" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "name" text NOT NULL,
    "period" bigint NOT NULL,
    "startDay" timestamp without time zone NOT NULL,
    "rotation" json NOT NULL,
    "rotationIndex" bigint NOT NULL,
    "archived" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "chore_flat_idx" ON "chore" USING btree ("flatId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "device_token" ADD COLUMN "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "device_token" ALTER COLUMN "updatedAt" SET DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "flat" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "flat" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "flat_event" ADD COLUMN "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "flat_event" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "grocery_item" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "grocery_item" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "mate" ADD COLUMN "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "mate" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "notice" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "notice" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "swap_debt" ADD COLUMN "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "swap_debt" ALTER COLUMN "createdAt" SET DEFAULT CURRENT_TIMESTAMP;
--
-- ACTION DROP TABLE
--
DROP TABLE "turn" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "turn" (
    "id" bigserial PRIMARY KEY,
    "flatId" bigint NOT NULL,
    "choreId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "coveringForMateId" bigint,
    "day" timestamp without time zone NOT NULL,
    "lastDay" timestamp without time zone NOT NULL,
    "status" text NOT NULL,
    "doneAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "turn_chore_idx" ON "turn" USING btree ("choreId");
CREATE INDEX "turn_flat_day_idx" ON "turn" USING btree ("flatId", "day");


--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261004173425585-days-and-timestamps', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004173425585-days-and-timestamps', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
