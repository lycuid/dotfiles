module Configs.Colors where

data Colors =
  Colors  { highlight   :: String
          , black       :: String
          , red         :: String
          , green       :: String
          , blue        :: String
          , cyan        :: String
          , white       :: String
          }

defColors :: Colors
defColors =
  Colors  { highlight   = "#2f3640"
          , black       = "#131313"
          , red         = "#eb2f06"
          , green       = "#2ed573"
          , blue        = "#30336b"
          , cyan        = "#00b894"
          , white       = "#c5cdd9"
          }

