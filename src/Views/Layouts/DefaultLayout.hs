module Views.Layouts.DefaultLayout (
  defaultLayout
) where

import Prelude hiding (div, head, id, span)

import Data.Monoid (mempty)
import Data.String (fromString)
import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (title)

import Views.Page
import Views.Layouts.NavBar

defaultLayout :: Page -> Html
defaultLayout page =
  docTypeHtml ! lang "en" $ do
    head $
      do meta ! charset "utf-8"
         meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge"
         meta ! name "viewport" ! content "width=device-width, initial-scale=1"
         title $ toHtml $ pageTitle page
         --  Bootstrap
         link ! href "/lib/bootstrap-css/css/bootstrap.min.css" ! rel "stylesheet"
         link ! href "/css/style.css" ! rel "stylesheet"
         sequence_ [link ! href (fromString cssFilePath) ! rel "stylesheet" | cssFilePath <- pageStylesheets page]
    body $
      do div ! class_ "wrap" $
           do navBar
              div ! class_ "row" $
                do div ! id "content" ! class_ "col-xs-12" $ pageContent page
         --  External Javascript Libs
         script ! src "/lib/jquery/dist/jquery.min.js" $ mempty
         script ! src "/lib/bootstrap-css/js/bootstrap.min.js" $ mempty
         -- My app resources
         script ! src "/js/app.js" $ mempty
         sequence_ [script ! src (fromString jsFilePath) $ mempty | jsFilePath <- pageScripts page]
