module App.View.Aboutpage where

import App.Events (Event)
import App.State (State)
import Pux.DOM.HTML (HTML)
import Data.Function (($))
import Text.Smolder.HTML (a, div, h1)
import Text.Smolder.Markup (text)

view :: State -> HTML Event
view s = div do
  h1 $ text "About page"
