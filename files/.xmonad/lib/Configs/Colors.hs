module Configs.Colors where

data Colors =
  Colors  { light   :: String
          , dark    :: String
          , hlDark  :: String
          , green   :: String
          , teal    :: String
          , blue    :: String
          , red     :: String
          }

defColors :: Colors
defColors =
  Colors  { light   = "#c5cdd9"
          , dark    = "#131313"
          , hlDark  = "#2f3640"
          , green   = "#2ed573"
          , teal    = "#00b894"
          , blue    = "#30336b"
          , red     = "#eb2f06"
          }

