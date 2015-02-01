module Main where

import Control.Monad.IO.Class (liftIO)
import Network.Wai.Middleware.Gzip
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Web.Scotty
import Utils (getPort, runMigration)

import qualified Controllers.Application as AppCtrl

main :: IO ()
main =
  do port <- getPort 3000
     scotty port $ do
       middleware logStdoutDev
       middleware $ gzip def
       middleware $ staticPolicy (noDots >-> addBase "static")

       liftIO runMigration

       get     "/"               AppCtrl.index
       post    "/addUser"        AppCtrl.addUser
