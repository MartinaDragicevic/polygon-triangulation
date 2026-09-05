module Main (main) where

import PolygonGenerator
import System.Random (mkStdGen)

main :: IO ()
main = do
    let generator = mkStdGen 42
        (points, _) = generateUniquePoints 10 (0, 1) generator

    print points