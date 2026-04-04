{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Miso 
  ( reload 
  , defaultEvents
  , startApp
  , App
  , Component(styles)
  , component
  , Effect
  , noop
  , View
  , text
  , CSS(Sheet))
import Miso.CSS qualified as Css

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
app = (component init_state next_state view_state)
      { styles = [ Sheet style ]
      }

init_state :: State
init_state = ()

next_state :: Action -> Effect parent State Action
next_state = noop

view_state :: State -> View State Action
view_state state = text "Hello, Miso!"

style :: Css.StyleSheet
style = Css.sheet_ []