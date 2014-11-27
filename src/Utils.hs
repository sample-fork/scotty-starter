module Utils (
  blaze
) where

import Text.Blaze.Html.Renderer.Text (renderHtml)
import Web.Scotty

blaze = html . renderHtml
