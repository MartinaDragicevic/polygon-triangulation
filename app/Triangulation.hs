module Triangulation where

import Types (Point)

type Triangle = (Point, Point, Point)

triangulateConvex :: [Point] -> [Triangle]
triangulateConvex (first : second : third : rest) =
    (first, second, third) : buildTriangles first third rest
  where
    buildTriangles _ _ [] = []
    buildTriangles anchor previous (next : remaining) =
        (anchor, previous, next) : buildTriangles anchor next remaining

triangulateConvex _ = []