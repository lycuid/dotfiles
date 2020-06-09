module Configs.Colors where

data Colors =
  Colors  { light   :: String
          , dark    :: String
          , hlDark  :: String
          , green   :: String
          , blue    :: String
          }

defColors :: Colors
defColors =
  Colors  { light   = "#c5cdd9"
          , dark    = "#131313"
          , hlDark  = "#353b48"
          , green   = "#2ed573"
          , blue    = "#30336b"
          }

nvimColors :: Colors
nvimColors =
  defColors { light   = "#c5cdd9"
            , dark    = "#131313"
            , hlDark  = "#353b48"
            }

