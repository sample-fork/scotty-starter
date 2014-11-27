module Main where

import Control.Applicative ((<$>), (<*>))
import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Types
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Web.Scotty

import qualified Database.Persist.Sqlite as Db
import qualified Controllers.Application as AppCtrl

main :: IO()
main =
  scotty 3000 $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ AppCtrl.index

    notFound $ AppCtrl.return404
