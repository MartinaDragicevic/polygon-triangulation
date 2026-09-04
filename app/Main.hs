module Main (main) where

import Geometry
import Types

main :: IO ()
main = do
    let simplePolygon = [Point 0 0, Point 4 0, Point 4 4, Point 0 4]
        selfIntersectingPolygon = [Point 0 0, Point 4 4, Point 0 4, Point 4 0]

    print (isSimplePolygon simplePolygon)
    print (isSimplePolygon selfIntersectingPolygon)