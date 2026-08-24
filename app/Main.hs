module Main (main) where

import PolygonGenerator
import System.Random (mkStdGen)

main :: IO ()
main = do
    let generator = mkStdGen 42
    let (points, _) = generatePoints 5 (0, 100) generator
    print points