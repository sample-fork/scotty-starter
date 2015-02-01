{-# LANGUAGE DataKinds #-}
module Models.User (
  User(..), UserId(..), create, findById, findAll, delete
) where

import Control.Applicative
import Control.Monad
import Data.Aeson
import Data.Text
import Data.Time.Clock (UTCTime)
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow (field, fromRow)
import Database.PostgreSQL.Simple.ToRow (toRow)
import Database.PostgreSQL.Simple.ToField (toField)

import Utils

type Password = Text
newtype UserId = UserId Text deriving (Read, Show)

data User = User {userId :: UserId
                 , password :: Password
                 , created :: UTCTime
                 , lastModified :: Maybe UTCTime
                 }

instance ToJSON User where
  toJSON (User (UserId i) passwd created lastModified) =
    object ["username" .= i
      , "password" .= passwd
      , "created" .= created
      , "modified" .= lastModified
      ]

instance FromJSON User where
  parseJSON (Object v) = User <$> (UserId <$> v .: "username")
                                  <*> v .: "password"
                                  <*> v .: "created"
                                  <*> v .: "modified"
  parseJSON _ = mzero

instance FromRow User where
  fromRow = User <$> (UserId <$> field) <*> field <*> field <*> field

instance ToRow User where
  toRow (User (UserId i) passwd created modified) =
    [toField i, toField passwd, toField created, toField modified]

instance ToRow UserId where
  toRow (UserId i) = [toField i]

instance Show User where
  show = show . toJSON

create :: UserId -> Password -> IO ()
create (UserId u) passwd =
  do conn <- getDb
     _ <- execute conn "insert into users (username, password) values (?, ?)" (u, passwd)
     return ()

findById :: UserId -> IO (Maybe User)
findById userId =
  do conn <- getDb
     xs <- query conn "select username, password, created, modified from users where username = ?" userId
                 :: IO [User]
     case xs of
        [] -> return Nothing
        user : _ -> return $ Just user

findAll :: IO [User]
findAll = getDb >>= flip query_ "select username, password, created, modified from users" :: IO [User]

delete :: UserId -> IO ()
delete userId =
  do conn <- getDb
     _ <- execute conn "delete from users where username = ?" userId
     return ()
