module Main (main) where

import Triangulation
import Types

main :: IO ()
main = do
    let triangle =
            ( Point 0 0
            , Point 6 0
            , Point 3 6
            )

    print (pointInTriangle (Point 3 2) triangle)
    print (pointInTriangle (Point 7 2) triangle)