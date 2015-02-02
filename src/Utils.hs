module Utils (
  blaze, getDb, getPort, runMigration, badRequest
) where

import Control.Monad (liftM)
import Data.ByteString.Char8 (pack)
import Data.Maybe (fromMaybe)
import Data.Monoid (mconcat)
import Database.PostgreSQL.Simple
import Network.HTTP.Types
import System.Environment (lookupEnv)
import Text.Blaze.Html5 (Html)
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Web.Scotty

import qualified Data.Text as T
import qualified Data.Text.Lazy as TL

import Models.Migration

blaze :: Html -> ActionM ()
blaze = html . renderHtml

-- Connection string format: "host=localhost port=5432 dbname=test user=user1 password=secret"
-- Heroku DATABASE_URL format: "postgres://user:password@host:port/dbname"
parseHerokuDbUri :: T.Text -> T.Text
parseHerokuDbUri uri =
  let parts = T.splitOn "@" $ T.drop 11 uri
      userInfo = T.splitOn ":" $ head parts
      serverInfo = T.splitOn "/" $ head $ tail parts
      user = head userInfo
      pass = head $ tail userInfo
      host = head $ T.splitOn ":" $ head serverInfo
      port = head . tail $ T.splitOn ":" $ head serverInfo
      dbname = head $ tail serverInfo
  in
    mconcat ["host=", host, " port=", port, " user=", user, " password=", pass, " dbname=", dbname]

getDb :: IO Connection
getDb =
  do maybeHerokuDbUri <- lookupEnv "DATABASE_URL"
     maybeLocalDbUri <- lookupEnv "PG_URI"
     let connStr = case liftM parseHerokuDbUri $ fmap T.pack maybeHerokuDbUri of
                      Nothing -> fromMaybe "" maybeLocalDbUri
                      Just cs -> T.unpack cs

     connectPostgreSQL $ pack connStr

getPort :: Int -> IO Int
getPort defaultPort =
  do maybePort <- lookupEnv "PORT"
     case maybePort of
      Nothing -> return defaultPort
      Just strPort -> return $ read strPort

badRequest :: TL.Text -> ActionM ()
badRequest _ = status badRequest400

runMigration :: IO ()
runMigration =
  do conn <- getDb
     putStrLn "running db migrations..."
     _ <- execute_ conn q
     putStrLn "migrations all done, yay!"
