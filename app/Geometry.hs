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

segmentsIntersect :: Point -> Point -> Point -> Point -> Bool
segmentsIntersect p1 p2 p3 p4 =
    let o1 = orientation p1 p2 p3
        o2 = orientation p1 p2 p4
        o3 = orientation p3 p4 p1
        o4 = orientation p3 p4 p2
    in oppositeSigns o1 o2 && oppositeSigns o3 o4
  where
    oppositeSigns a b = (a > 0 && b < 0) || (a < 0 && b > 0)

polygonEdges :: Polygon -> [(Point, Point)]
polygonEdges [] = []
polygonEdges points = zip points (tail points ++ [head points])

isSimplePolygon :: Polygon -> Bool
isSimplePolygon polygon
    | length polygon < 3 = False
    | otherwise = not (any edgesIntersect edgePairs)
  where
    edges = polygonEdges polygon
    indexedEdges = zip [0 ..] edges
    edgeCount = length edges

    edgePairs =
        [ (edge1, edge2)
        | (i, edge1) <- indexedEdges
        , (j, edge2) <- indexedEdges
        , i < j
        , not (areAdjacent i j edgeCount)
        ]

    areAdjacent i j n = j == i + 1 || (i == 0 && j == n - 1)

    edgesIntersect ((a, b), (c, d)) = segmentsIntersect a b c d