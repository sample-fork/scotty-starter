module Views.Application.Index where

import Control.Applicative
import Data.Text (Text)
import qualified Data.Text as T
import Models.User
import Prelude hiding (div, head, id, span)
import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (form, label)
import Text.Digestive ((.:), check)
import qualified Text.Digestive as D
import Views.Layouts.DefaultLayout
import Views.Page

data AddUser = AddUser {username :: Text
                       , password :: Text}

addUserFormValidate :: Monad m => D.Form Text m AddUser
addUserFormValidate = AddUser
                      <$> "username" .: check "Username can't be empty" (not . T.null) (D.text Nothing)
                      <*> "password" .: check "Password can't be empty" (not . T.null) (D.text Nothing)

indexPage :: [User] -> Page
indexPage users = def {pageTitle = "Scotty Starter",
                       pageContent = index' users,
                       pageScripts = ["/js/app-index.js"]}

index :: [User] -> Html
index users = defaultLayout $ indexPage users

-- this is for when wish to render the view without a layout e.g. ajax
index' :: [User] -> Html
index' users =
  do div ! class_ "row" $
       do div ! class_ "col-xs-12" $
            do h3 $ "List of Users"
               ul $
                 do sequence_ [li $ toHtml u | UserId u <- map userId users]
     div ! class_ "row" $
       do div ! class_ "col-xs-8" $
            do form ! action "/addUser" $
                 do div ! class_ "form-group" $
                      do label ! class_ "control-label" $ "Username:"
                         input ! class_ "form-control" ! type_ "text" ! name "form.username"
                    div ! class_ "form-group" $
                      do label ! class_ "control-label" $ "Password:"
                         input ! class_ "form-control" ! type_ "password" ! name "form.password"
                    div ! class_ "form-group" $
                      do button ! id "btn-create" ! class_ "btn btn-small btn-primary" ! type_ "button" $ "Add User"
