module Triangulation where

type Triangle a = (a, a, a)

triangulateConvex :: [a] -> [Triangle a]
triangulateConvex (first : second : third : rest) =
    (first, second, third) : buildTriangles first third rest
  where
    buildTriangles _ _ [] = []
    buildTriangles anchor previous (next : remaining) =
        (anchor, previous, next)
            : buildTriangles anchor next remaining

triangulateConvex _ = []