module Geometry where

import Types (Point(..), Polygon)

orientation :: Point -> Point -> Point -> Int
orientation (Point ax ay) (Point bx by) (Point cx cy) =
    (bx - ax) * (cy - ay) - (by - ay) * (cx - ax)

isConvex :: Polygon -> Bool
isConvex polygon
    | length polygon < 3 = False
    | null turns = False
    | otherwise = all (> 0) turns || all (< 0) turns
  where
    extended = polygon ++ take 2 polygon
    allTurns = zipWith3 orientation extended (drop 1 extended) (drop 2 extended)
    turns = filter (/= 0) allTurns