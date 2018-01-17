module App.View.Layout where

import App.View.Homepage as Homepage
import App.View.Aboutpage as Aboutpage
import App.View.NotFound as NotFound
import App.Routes (Route(NotFound, Home, About))
import App.State (State(..))
import App.Events (Event(..))
import Control.Bind (discard)
import Data.Function (($))
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onClick)
import Text.Smolder.HTML (div, header, nav, ul, a)
import Text.Smolder.HTML.Attributes (className, href)
import Text.Smolder.Markup ((!), (#!), text)

layoutHeader :: HTML Event
layoutHeader = do
  header $ do
    nav $ do
      ul $ do
        a ! href "/" #! onClick (Navigate "/") $ text "Home"
        a ! href "/about" #! onClick (Navigate "/about") $ text "About"

view :: State -> HTML Event
view (State st) =
  div ! className "app" $ do
    layoutHeader
    case st.route of
      (Home) -> Homepage.view (State st)
      (NotFound url) -> NotFound.view (State st)
      (About) -> Aboutpage.view (State st)
