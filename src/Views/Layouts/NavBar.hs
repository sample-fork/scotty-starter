module Views.Layouts.NavBar (
  navBar
) where

import Prelude hiding (div, head, id, span)

import Data.Monoid (mempty)
import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (title, span)

navBar :: Html
navBar =
  nav ! class_ "navbar navbar-default" ! customAttribute "role" "navigation" $ do
    div ! class_ "container-fluid" $ do
      --  Brand and toggle get grouped for better mobile display
      div ! class_ "navbar-header" $ do
        button ! type_ "button" ! class_ "navbar-toggle collapsed" ! dataAttribute "toggle" "collapse" ! dataAttribute "target" "#navbar-collapse-1" $ do
          span ! class_ "sr-only" $ "Toggle navigation"
          span ! class_ "icon-bar" $ mempty
          span ! class_ "icon-bar" $ mempty
          span ! class_ "icon-bar" $ mempty
        a ! class_ "navbar-brand" ! href "#" $ "Scotty Starter"
          --  Collect the nav links, forms, and other content for toggling
      div ! class_ "collapse navbar-collapse" ! id "navbar-collapse-1" $ do
        ul ! class_ "nav navbar-nav" $ do
          li ! class_ "active" $ a ! href "#" $ do
            _ <- "Home"
            span ! class_ "sr-only" $ "(current)"
          li $ a ! href "#" $ "Page 2"
        ul ! class_ "nav navbar-nav navbar-right" $ li $ a ! href "#" $ "Sign In"
