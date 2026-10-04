import 'package:serverpod/serverpod.dart';

/// Makes Postgres set "updatedAt" on every update, for each of our tables
/// that has the column. Runs at startup rather than in a migration because
/// a fresh database is built from definition.sql, which never includes it.
/// Idempotent.
Future<void> installUpdatedAtTriggers(Session session) =>
    session.db.unsafeSimpleExecute(r'''
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN
  NEW."updatedAt" = now();
  RETURN NEW;
END $$ LANGUAGE plpgsql;

DO $$
DECLARE t text;
BEGIN
  FOR t IN
    SELECT table_name FROM information_schema.columns
    WHERE table_schema = current_schema()
      AND column_name = 'updatedAt'
      AND table_name NOT LIKE 'serverpod%'
  LOOP
    EXECUTE format(
      'CREATE OR REPLACE TRIGGER %I BEFORE UPDATE ON %I '
      'FOR EACH ROW EXECUTE FUNCTION set_updated_at()',
      t || '_updated_at', t);
  END LOOP;
END $$;
''');
