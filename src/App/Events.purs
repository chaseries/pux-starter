module App.Events where

import Prelude
import App.Routes (Route, match)
import App.State (State(..))
import Control.Monad.Eff.Class (liftEff)
import Data.Maybe (Maybe(..))
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects, onlyEffects)
import Pux.DOM.Events (DOMEvent)
import DOM.Event.Event (preventDefault)
import DOM.HTML (window)
import DOM.HTML.Window (history)
import DOM.HTML.History (URL(..), DocumentTitle(..), pushState)
import DOM.HTML.Types (HISTORY)
import DOM (DOM)
import Data.Foreign (toForeign)


data Event = PageView Route
           | Navigate String DOMEvent 


type AppEffects fx = (ajax :: AJAX, history :: HISTORY, dom :: DOM | fx)


foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (Navigate url ev) st =
  onlyEffects st [ liftEff do
                     preventDefault ev
                     h <- history =<< window
                     pushState (toForeign {}) (DocumentTitle "") (URL url) h
                     pure $ Just $ PageView (match url)
                 ]
