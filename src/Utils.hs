module Utils (
  blaze, getDbUri
) where

import System.Environment (getEnv)
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Web.Scotty

blaze = html . renderHtml

-- Connection string format: "host=localhost port=5432 dbname=test user=user1 password=secret"

getDbUri :: IO String
getDbUri = do
  s <- getEnv "DB_CONNECTION_STRING"
  return s
