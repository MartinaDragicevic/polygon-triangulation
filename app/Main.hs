module Main (main) where

import Geometry (isConvex, isSimplePolygon)
import PolygonGenerator (generatePolygon)
import System.Random (mkStdGen)
import Triangulation (triangulatePolygon)
import Types (PolygonType(..))

main :: IO ()
main = do
    let convexGen = mkStdGen 42
        nonConvexGen = mkStdGen 100

        (convexPolygon, _) =
            generatePolygon Convex 6 (0, 100) convexGen

        (nonConvexPolygon, _) =
            generatePolygon NonConvex 6 (0, 100) nonConvexGen

    putStrLn "=== Convex polygon ==="
    print convexPolygon
    putStrLn ("Simple: " ++ show (isSimplePolygon convexPolygon))
    putStrLn ("Convex: " ++ show (isConvex convexPolygon))
    putStrLn "Triangulation:"
    print (triangulatePolygon convexPolygon)

    putStrLn "\n=== Non-convex polygon ==="
    print nonConvexPolygon
    putStrLn ("Simple: " ++ show (isSimplePolygon nonConvexPolygon))
    putStrLn ("Convex: " ++ show (isConvex nonConvexPolygon))
    putStrLn "Triangulation:"
    print (triangulatePolygon nonConvexPolygon)