BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "flat" ADD COLUMN "morningSummaryAt" bigint NOT NULL DEFAULT 480;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "mate" DROP COLUMN "notifyMissed";
ALTER TABLE "mate" ADD COLUMN "notifyMatesNotDone" boolean NOT NULL DEFAULT true;

--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261012095714897-notify-summaries', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261012095714897-notify-summaries', "timestamp" = now();

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
