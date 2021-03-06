module App.Routes where

import Data.Function (($))
import Data.Functor ((<$))
import Control.Alt ((<|>))
import Control.Apply ((<*))
import Data.Foreign.Class (class Decode, class Encode)
import Data.Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (fromMaybe)
import Data.Show (class Show)
import Pux.Router (lit, end, router)

data Route = Home 
           | About 
           | NotFound String

derive instance genericRoute :: Generic Route _
instance showRoute :: Show Route where show = genericShow
instance decodeRoute :: Decode Route where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
instance encodeRoute :: Encode Route where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

match :: String -> Route
match url = fromMaybe (NotFound url) $ router url $
  Home <$ end <|>
  About <$ (lit "about") <* end

toURL :: Route -> String
toURL (NotFound url) = url
toURL (Home) = "/"
toURL (About) = "/about"


