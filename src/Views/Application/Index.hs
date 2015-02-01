module Views.Application.Index where

import Prelude hiding (div, head, id, span)

import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (form, label)

import Models.User
import Views.Page
import Views.Layouts.DefaultLayout

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
                         input ! class_ "form-control" ! type_ "text" ! name "username"
                    div ! class_ "form-group" $
                      do label ! class_ "control-label" $ "Password:"
                         input ! class_ "form-control" ! type_ "password" ! name "password"
                    div ! class_ "form-group" $
                      do button ! id "btn-create" ! class_ "btn btn-small btn-primary" ! type_ "button" $ "Add User"
