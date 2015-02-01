module Views.Page (Page(..), def) where

import Data.Default
import Data.Monoid (mempty)
import Data.Text
import Text.Blaze.Html5 (Html)
import System.FilePath (FilePath)

type Title = Text
data Page = Page {pageTitle :: Title,
                  pageStylesheets :: [FilePath],
                  pageScripts :: [FilePath],
                  pageContent :: Html
                 }

instance Default Page where
  def = Page {pageTitle = "",
              pageStylesheets = [],
              pageScripts = [],
              pageContent = mempty
             }
