module Main (main) where

import Geometry
import PolygonGenerator
import System.Random (mkStdGen)

main :: IO ()
main = do
    let generator = mkStdGen 42
        (polygon, _) = generateSimplePolygon 10 (0, 100) generator

    print polygon
    print (isSimplePolygon polygon)