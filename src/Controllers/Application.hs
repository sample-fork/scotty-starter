module Controllers.Application (
  index
) where

import Web.Scotty
import Network.HTTP.Types
import qualified Views.Application.Index as Views

index :: ActionM
index = html Views.index

return404 :: ActionM
return404 = do
  status notFound404
  text "The requested resource was not found on this server."
