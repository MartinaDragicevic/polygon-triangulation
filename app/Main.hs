module Main (main) where

import PolygonGenerator
import System.Random (mkStdGen)
import Triangulation

main :: IO ()
main = do
    let generator = mkStdGen 42
    let (points, _) = generateUniquePoints 10 (0, 100) generator
    print points
    print (triangulateConvex ([1, 2, 3, 4, 5] :: [Int]))