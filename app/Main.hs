module Main (main) where

import Geometry
import PolygonGenerator
import System.Random (mkStdGen)
import Types

main :: IO ()
main = do
    let convexGen = mkStdGen 42
        nonConvexGen = mkStdGen 100

        (convexPolygon, _) = generatePolygon Convex 5 (0, 100) convexGen

        (nonConvexPolygon, _) = generatePolygon NonConvex 5 (0, 100) nonConvexGen

    putStrLn "Convex polygon:"
    print convexPolygon
    print (isConvex convexPolygon)

    putStrLn "Non-convex polygon:"
    print nonConvexPolygon
    print (isConvex nonConvexPolygon)