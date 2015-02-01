module Controllers.Application (
  index, addUser, return404
) where

import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Types
import Web.Scotty
import qualified Views.Application.Index as Views

import Utils
import qualified Models.User as User

index :: ActionM ()
index =
  do users <- liftIO User.findAll
     blaze $ Views.index users

addUser :: ActionM ()
addUser =
  addUser' `rescue` badRequest where
    addUser' =
      do u <- param "username"
         p <- param "password"
         let userId = User.UserId u
         liftIO $  User.create userId p
         status created201

return404 :: ActionM ()
return404 = do
  status notFound404
  html "The requested resource was not found on this server."
