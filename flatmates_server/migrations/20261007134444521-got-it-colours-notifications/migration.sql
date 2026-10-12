BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "mate" ADD COLUMN "color" text NOT NULL DEFAULT 'tomato'::text;
ALTER TABLE "mate" ADD COLUMN "notifyTurnStarts" boolean NOT NULL DEFAULT true;
ALTER TABLE "mate" ADD COLUMN "notifyReminder" boolean NOT NULL DEFAULT true;
ALTER TABLE "mate" ADD COLUMN "notifyMissed" boolean NOT NULL DEFAULT true;
ALTER TABLE "mate" ADD COLUMN "notifyNotice" boolean NOT NULL DEFAULT true;
ALTER TABLE "mate" ADD COLUMN "notifyAddedToRotation" boolean NOT NULL DEFAULT true;
-- Spread existing active Mates over the colours, in join order per Flat.
UPDATE "mate" m SET "color" =
    (ARRAY['tomato','sky','plum','leaf','marigold','berry'])[(r.n - 1) % 6 + 1]
FROM (SELECT "id", row_number() OVER (PARTITION BY "flatId" ORDER BY "joinedAt") AS n
      FROM "mate" WHERE "leftAt" IS NULL) r
WHERE m."id" = r."id";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "notice_got_it" (
    "id" bigserial PRIMARY KEY,
    "noticeId" bigint NOT NULL,
    "mateId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "notice_got_it_idx" ON "notice_got_it" USING btree ("noticeId", "mateId");


--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261007134444521-got-it-colours-notifications', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007134444521-got-it-colours-notifications', "timestamp" = now();

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
