{-# LANGUAGE OverloadedStrings #-}

module Controllers.Application (
  index, return404
) where

import Web.Scotty
import Network.HTTP.Types
import qualified Views.Application.Index as Views

import Utils

index :: ActionM ()
index = blaze Views.index

return404 :: ActionM ()
return404 = do
  status notFound404
  html "The requested resource was not found on this server."
