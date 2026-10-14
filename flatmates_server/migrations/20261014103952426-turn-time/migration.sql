BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "chore" ADD COLUMN "turnTime" text NOT NULL DEFAULT 'evening'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "flat" DROP COLUMN "morningSummaryAt";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "mate" ADD COLUMN "notifyNightSummary" boolean NOT NULL DEFAULT true;

--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261014103952426-turn-time', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014103952426-turn-time', "timestamp" = now();

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
