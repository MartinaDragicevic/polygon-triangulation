module Main (main) where

import Geometry
import Types

main :: IO ()
main = do
    let convexPolygon =
            [ Point 0 0
            , Point 4 0
            , Point 4 4
            , Point 0 4
            ]

    let nonConvexPolygon =
            [ Point 0 0
            , Point 4 0
            , Point 2 2
            , Point 4 4
            , Point 0 4
            ]

    print (isConvex convexPolygon)
    print (isConvex nonConvexPolygon)