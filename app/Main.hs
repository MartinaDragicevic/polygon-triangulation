module Main (main) where

import PolygonGenerator
import System.Random (mkStdGen)
import Triangulation
import Types

main :: IO ()
main = do
    let polygon = [Point 0 0, Point 4 0, Point 4 4, Point 2 2, Point 0 4]
        clockwisePolygon = reverse polygon
        generator = mkStdGen 42
        (tooManyPoints, _) = generatePolygon Convex 10 (0, 1) generator
        (invalidNonConvex, _) = generatePolygon NonConvex 3 (0, 100) generator

    putStrLn "Triangulation:"
    print (triangulatePolygon polygon)
    print (triangulatePolygon clockwisePolygon)

    putStrLn "Invalid generation requests:"
    print tooManyPoints
    print invalidNonConvex