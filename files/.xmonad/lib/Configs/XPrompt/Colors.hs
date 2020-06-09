module Configs.XPrompt.Colors where

data XPColor =
  XPColor { light   :: String
          , dark    :: String
          , hlDark  :: String
          , green   :: String
          , blue    :: String
          }

defXPColor :: XPColor
defXPColor =
  XPColor { light   = "#c5cdd9"
          , dark    = "#131313"
          , hlDark  = "#353b48"
          , green   = "#2ed573"
          , blue    = "#30336b"
          }

nvimColor :: XPColor
nvimColor =
  defXPColor  { light   = "#c5cdd9"
              , dark    = "#131313"
              , hlDark  = "#353b48"
              }

