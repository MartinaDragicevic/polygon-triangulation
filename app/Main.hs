module Main (main) where

import Geometry (isConvex, isSimplePolygon)
import PolygonGenerator (generatePolygon)
import System.Random (mkStdGen, newStdGen)
import Triangulation (triangulatePolygon)
import Types (Polygon, PolygonType(..))
import Visualization (savePolygonSVG)

main :: IO ()
main = do
    let fixedConvexGen = mkStdGen 42
        fixedNonConvexGen = mkStdGen 100
        (fixedConvex, _) = generatePolygon Convex 6 (0, 100) fixedConvexGen
        (fixedNonConvex, _) = generatePolygon NonConvex 6 (0, 100) fixedNonConvexGen

    randomConvexGen <- newStdGen
    randomNonConvexGen <- newStdGen

    let (randomConvex, _) = generatePolygon Convex 6 (0, 100) randomConvexGen
        (randomNonConvex, _) = generatePolygon NonConvex 6 (0, 100) randomNonConvexGen

    putStrLn "=== Fixed examples ==="
    printPolygonResult "Convex polygon" fixedConvex
    printPolygonResult "Non-convex polygon" fixedNonConvex

    putStrLn "\n=== Random examples ==="
    printPolygonResult "Random convex polygon" randomConvex
    printPolygonResult "Random non-convex polygon" randomNonConvex

    savePolygonSVG "fixed-convex.svg" fixedConvex (triangulatePolygon fixedConvex)
    savePolygonSVG "fixed-nonconvex.svg" fixedNonConvex (triangulatePolygon fixedNonConvex)
    savePolygonSVG "random-convex.svg" randomConvex (triangulatePolygon randomConvex)
    savePolygonSVG "random-nonconvex.svg" randomNonConvex (triangulatePolygon randomNonConvex)

printPolygonResult :: String -> Polygon -> IO ()
printPolygonResult title polygon = do
    putStrLn ("\n" ++ title ++ ":")
    print polygon
    putStrLn ("Simple: " ++ show (isSimplePolygon polygon))
    putStrLn ("Convex: " ++ show (isConvex polygon))
    putStrLn "Triangulation:"
    print (triangulatePolygon polygon)