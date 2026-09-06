module Main (main) where

import PolygonGenerator
import System.Random (mkStdGen)
import Types

main :: IO ()
main = do
    let generator = mkStdGen 42
        (tooManyPoints, _) = generatePolygon Convex 10 (0, 1) generator
        (invalidNonConvex, _) = generatePolygon NonConvex 3 (0, 100) generator

    print tooManyPoints
    print invalidNonConvex