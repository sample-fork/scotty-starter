module Controllers.Application (
  index, addUser, addUserDigestive, return404
) where

import Control.Monad.IO.Class (liftIO)
import qualified Models.User as User
import Network.HTTP.Types
import Text.Digestive.Scotty (runForm)
import Utils
import qualified Views.Application.Index as Views
import Web.Scotty

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

addUserDigestive :: ActionM ()
addUserDigestive =
  do (formErrs, userForm) <- runForm "form" Views.addUserFormValidate
     case userForm of
      Just f ->
        do liftIO $ User.create userId passwd
           status created201 where
             userId = User.UserId $ Views.username f
             passwd = Views.password f
      _ ->
        do liftIO $ print formErrs
           status badRequest400

return404 :: ActionM ()
return404 = do
  status notFound404
  html "The requested resource was not found on this server."
