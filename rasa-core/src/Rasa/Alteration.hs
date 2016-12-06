{-# LANGUAGE TemplateHaskell #-}
module Rasa.Alteration where

import Control.Monad.State
import Data.Dynamic

import Rasa.Event
import Rasa.Editor

import Control.Lens
import Data.Default

data Store = Store
  { _event :: [Event]
  , _editor :: Editor
  , _extState :: [Dynamic]
  }

makeLenses ''Store

instance Default Store where
  def =
    Store
    { _event = [def]
    , _editor = def
    , _extState = []
    }

type Alteration a = StateT Store IO a

runAlteration :: Alteration () -> Store -> IO Store
runAlteration = execStateT