module Views.Layouts.DefaultLayout (
  defaultLayout
) where

import Prelude hiding (div, head, id)

import Data.Monoid (mempty)
import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (title)

defaultLayout :: Html -> Html
defaultLayout part =
  docTypeHtml ! lang "en" ! customAttribute "ng-app" "" $ do
    head $
      do meta ! charset "utf-8"
         meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge"
         meta ! name "viewport" ! content "width=device-width, initial-scale=1"
         title "Scotty Angular Starter"
         --  Bootstrap
         link ! href "/lib/bootstrap-css/css/bootstrap.min.css" ! rel "stylesheet"
         link ! href "/lib/bootstrap-css/css/bootstrap-theme.min.css" ! rel "stylesheet"
    body $
      do h1 "Hello there!"
         part
         div ! customAttribute "ng-view" "" $ mempty
         --  External Javascript Libs
         script ! src "/lib/jquery/dist/jquery.min.js" $ mempty
         script ! src "/lib/jquery-ui/jquery-ui.min.js" $ mempty
         script ! src "/lib/bootstrap-css/js/bootstrap.min.js" $ mempty
         script ! src "/lib/angular/angular.min.js" $ mempty
         script ! src "/lib/angular-resource/angular-resource.min.js" $ mempty
         script ! src "/lib/angular-route/angular-route.min.js" $ mempty
         script ! src "/lib/angular-bootstrap/ui-bootstrap.min.js" $ mempty
         script ! src "/lib/angular-ui-date/src/date.js" $ mempty
         -- My app resources
         script ! src "/js/app.js" $ mempty
         script ! src "/js/controllers/home-ctrl.js" $ mempty
