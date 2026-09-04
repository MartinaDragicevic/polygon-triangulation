module Main (main) where

import Triangulation
import Types

main :: IO ()
main = do
    let polygon = [Point 0 0, Point 4 0, Point 4 4, Point 0 4]
        nonConvexPolygon = [Point 0 0, Point 4 0, Point 2 2, Point 4 4, Point 0 4]

    print (isEar (Point 0 0) (Point 4 0) (Point 4 4) polygon)
    print (isEar (Point 4 0) (Point 2 2) (Point 4 4) nonConvexPolygon)