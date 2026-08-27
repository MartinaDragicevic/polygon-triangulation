module Triangulation where

import Types (Point(..))

type Triangle = (Point, Point, Point)

triangulateConvex :: [Point] -> [Triangle]
triangulateConvex (first : second : third : rest) =
    (first, second, third) : buildTriangles first third rest
  where
    buildTriangles _ _ [] = []
    buildTriangles anchor previous (next : remaining) =
        (anchor, previous, next) : buildTriangles anchor next remaining

triangulateConvex _ = []

orientation :: Point -> Point -> Point -> Int
orientation (Point ax ay) (Point bx by) (Point cx cy) =
    (bx - ax) * (cy - ay) - (by - ay) * (cx - ax)

pointInTriangle :: Point -> Triangle -> Bool
pointInTriangle point (a, b, c) =
    let o1 = orientation a b point
        o2 = orientation b c point
        o3 = orientation c a point

        hasNegative = o1 < 0 || o2 < 0 || o3 < 0
        hasPositive = o1 > 0 || o2 > 0 || o3 > 0
    in not (hasNegative && hasPositive)