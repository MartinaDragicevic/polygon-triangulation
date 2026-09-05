module Main (main) where

import Triangulation
import Types

main :: IO ()
main = do
    let polygon = [Point 0 0, Point 4 0, Point 4 4, Point 2 2, Point 0 4]
        clockwisePolygon = reverse polygon

    print (triangulatePolygon polygon)
    print (triangulatePolygon clockwisePolygon)