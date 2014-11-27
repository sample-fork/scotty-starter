{-# LANGUAGE OverloadedStrings #-}

module Views.Layouts.DefaultLayout (
  defaultLayout
) where

import Prelude hiding (div, head, id)

import Text.Blaze.Html5 hiding (map, style)
import Text.Blaze.Html5.Attributes hiding (title)
import Text.Blaze.Html.Renderer.Text

import Utils

defaultLayout' part = do
  html $ do
    head $ title "Scotty Angular Starter"
    body $ do
      h1 "Hello there!"
      part

defaultLayout = blaze . defaultLayout'
