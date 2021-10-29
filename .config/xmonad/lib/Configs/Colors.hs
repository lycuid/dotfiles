module Configs.Colors where

import XMonad

data Colors = Colors
  { black :: String
  , red   :: String
  , green :: String
  , blue  :: String
  , cyan  :: String
  , white :: String
  }

instance Default Colors where
  def = Colors
    { black = "#131313"
    , red   = "#eb2f06"
    , green = "#2ed573"
    , blue  = "#30336b"
    , cyan  = "#089CAC"
    , white = "#ffffff"
    }

