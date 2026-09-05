module Main (main) where

import Geometry
import PolygonGenerator
import System.Random (mkStdGen)
import Triangulation
import Types

main :: IO ()
main = do
    let polygon = [Point 0 0, Point 4 0, Point 4 4, Point 2 2, Point 0 4]

        convexGen = mkStdGen 42
        nonConvexGen = mkStdGen 100
        (convexPolygon, _) = generatePolygon Convex 5 (0, 100) convexGen
        (nonConvexPolygon, _) = generatePolygon NonConvex 5 (0, 100) nonConvexGen

    putStrLn "Triangulation:"
    print (triangulatePolygon polygon)

    putStrLn "Convex polygon:"
    print convexPolygon
    print (isConvex convexPolygon)

    putStrLn "Non-convex polygon:"
    print nonConvexPolygon
    print (isConvex nonConvexPolygon)