{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Miso
import Miso.Lens
import Miso.String
import Miso.Html.Element as H 
import Miso.Html.Event as E 
import Miso.Html.Property as P 
import Miso.CSS qualified as CSS 

#ifdef WASM
#ifndef INTERACTIVE
foreign export javascript "hs_start" main :: IO ()
#endif
#endif

main :: IO ()
#ifdef INTERACTIVE
main = reload defaultEvents app
#else 
main = startApp defaultEvents app 
#endif

type State = ()

data Action
  = Skip
  deriving stock (Show, Eq)

app :: App State Action
app = (component init_state updateModel viewModel)
      { styles = []
      }

init_state :: State
init_state = ()

updateModel :: Action -> Effect parent State Action
updateModel = noop

viewModel :: State -> View State Action
viewModel state = text "Hello there!"

sheet :: CSS.StyleSheet
sheet = CSS.sheet_ []