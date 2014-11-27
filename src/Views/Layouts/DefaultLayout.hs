module Views.Layouts.DefaultLayout (
  defaultLayout
) where

import Prelude hiding (div, head, id)

import Data.Maybe
import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (title)
import Text.Blaze.Html.Renderer.Text

defaultLayout :: Html -> Html
defaultLayout part = do
  html $ do
    head $ do
      title $ toHtml "Scotty Angular Starter"
    body $ do
      h1 $ toHtml "Hello there!"
      part
