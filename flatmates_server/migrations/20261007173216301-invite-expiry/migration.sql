BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "flat" ADD COLUMN "inviteExpiresAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- Hand-added: existing Flats' codes get a fresh 7 days rather than expiring now.
UPDATE "flat" SET "inviteExpiresAt" = (now() AT TIME ZONE 'UTC') + interval '7 days';

--
-- MIGRATION VERSION FOR flatmates
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flatmates', '20261007173216301-invite-expiry', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007173216301-invite-expiry', "timestamp" = now();

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
