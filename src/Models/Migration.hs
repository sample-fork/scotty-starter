{-# LANGUAGE QuasiQuotes #-}
module Models.Migration (q) where

import Database.PostgreSQL.Simple (Query)
import Database.PostgreSQL.Simple.SqlQQ

q :: Query
q =
  [sql|
   -- SQL migration statements
   CREATE TABLE IF NOT EXISTS users
   (
   username character varying (32) PRIMARY KEY,
   password character varying(32) NOT NULL,
   created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
   modified timestamp with time zone
   );

  CREATE OR REPLACE FUNCTION update_modified_column()
  RETURNS TRIGGER AS $$
  BEGIN
  NEW.modified = now();
  RETURN NEW;
  END;
  $$ language 'plpgsql';

  DROP TRIGGER IF EXISTS update_user_modtime ON users CASCADE;
  CREATE TRIGGER update_user_modtime BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE  update_modified_column();
  |]
