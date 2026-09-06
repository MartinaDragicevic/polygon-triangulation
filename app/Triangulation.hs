module Triangulation where

import Geometry (orientation)
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


pointInTriangle :: Point -> Triangle -> Bool
pointInTriangle point (a, b, c) =
    let o1 = orientation a b point
        o2 = orientation b c point
        o3 = orientation c a point
        hasNegative = o1 < 0 || o2 < 0 || o3 < 0
        hasPositive = o1 > 0 || o2 > 0 || o3 > 0
    in not (hasNegative && hasPositive)

isEar :: Point -> Point -> Point -> [Point] -> Bool
isEar previous current next polygon =
    orientation previous current next > 0 && not (any insideTriangle otherPoints)
  where
    triangle = (previous, current, next)
    otherPoints =
        filter (\point -> point /= previous && point /= current && point /= next) polygon
    insideTriangle point = pointInTriangle point triangle

cyclicTriples :: [Point] -> [(Point, Point, Point)]
cyclicTriples (first : second : third : rest) =
    (lastPoint, first, second) : build first second (third : rest)
  where
    lastPoint = findLast third rest

    findLast current [] = current
    findLast _ (next : remaining) = findLast next remaining

    build previous current [] =
        [(previous, current, first)]
    build previous current (next : remaining) =
        (previous, current, next) : build current next remaining

cyclicTriples _ = []

findEar :: [Point] -> Maybe (Point, Triangle)
findEar polygon = search (cyclicTriples polygon)
  where
    search [] = Nothing
    search ((previous, current, next) : rest)
        | isEar previous current next polygon =
            Just (current, (previous, current, next))
        | otherwise = search rest

removePoint :: Point -> [Point] -> [Point]
removePoint _ [] = []
removePoint point (current : rest)
    | point == current = rest
    | otherwise = current : removePoint point rest

triangulatePolygon :: [Point] -> Maybe [Triangle]
triangulatePolygon polygon =
    triangulateCCW (ensureCounterClockwise polygon)
  where
    triangulateCCW [a, b, c] = Just [(a, b, c)]
    triangulateCCW points
        | length points < 3 = Nothing
        | otherwise =
            case findEar points of
                Nothing -> Nothing
                Just (earPoint, triangle) ->
                    case triangulateCCW (removePoint earPoint points) of
                        Nothing -> Nothing
                        Just triangles -> Just (triangle : triangles)

signedArea2 :: [Point] -> Int
signedArea2 [] = 0
signedArea2 (first : rest) =
    sum (zipWith crossProduct (first : rest) (rest ++ [first]))
  where
    crossProduct (Point x1 y1) (Point x2 y2) =
        x1 * y2 - x2 * y1

ensureCounterClockwise :: [Point] -> [Point]
ensureCounterClockwise polygon
    | signedArea2 polygon < 0 = reverse polygon
    | otherwise = polygon