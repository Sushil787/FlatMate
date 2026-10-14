BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "mate" ADD COLUMN "onboardedAt" timestamp without time zone;

-- Mates from before onboarding existed have nothing to practise.
UPDATE "mate" SET "onboardedAt" = "joinedAt";

--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261014083102162-onboarded-at', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014083102162-onboarded-at', "timestamp" = now();

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
