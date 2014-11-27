module Views.Application.Index where

import Prelude hiding (div, head, id, span)

import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes

import Views.Layouts.DefaultLayout (defaultLayout)

index' =
  div $ em "I am index!"

index = defaultLayout index'
