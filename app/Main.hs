module Main (main) where

import Triangulation
import Types

main :: IO ()
main =
    print
        (triangulateConvex
            [ Point 0 0
            , Point 4 0
            , Point 4 4
            , Point 0 4
            ])