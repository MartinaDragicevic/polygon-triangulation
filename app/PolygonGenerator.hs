module PolygonGenerator where

import Data.List (sortOn)
import Geometry (isConvex, isSimplePolygon)
import System.Random (StdGen, uniformR)
import Types (Point(..), Polygon, PolygonType(..))

generatePoint :: (Int, Int) -> StdGen -> (Point, StdGen)
generatePoint range gen =
    let (x, gen1) = uniformR range gen
        (y, gen2) = uniformR range gen1
    in (Point x y, gen2)

generatePoints :: Int -> (Int, Int) -> StdGen -> ([Point], StdGen)
generatePoints 0 _ gen = ([], gen)
generatePoints n range gen =
    let (point, gen1) = generatePoint range gen
        (points, gen2) = generatePoints (n - 1) range gen1
    in (point : points, gen2)

generateUniquePoints :: Int -> (Int, Int) -> StdGen -> ([Point], StdGen)
generateUniquePoints count range@(minValue, maxValue) gen
    | count <= 0 = ([], gen)
    | minValue > maxValue = ([], gen)
    | count > availablePoints = ([], gen)
    | otherwise = generate count [] gen
  where
    sideLength = maxValue - minValue + 1
    availablePoints = sideLength * sideLength

    generate 0 points currentGen = (reverse points, currentGen)
    generate remaining points currentGen =
        let (point, nextGen) = generatePoint range currentGen
        in if point `elem` points
            then generate remaining points nextGen
            else generate (remaining - 1) (point : points) nextGen


orderPoints :: [Point] -> Polygon
orderPoints [] = []
orderPoints points = sortOn angle points
  where
    count :: Double
    count = fromIntegral (length points)

    centerX :: Double
    centerX = fromIntegral (sum [x | Point x _ <- points]) / count

    centerY :: Double
    centerY = fromIntegral (sum [y | Point _ y <- points]) / count

    angle :: Point -> Double
    angle (Point x y) =
        atan2 (fromIntegral y - centerY) (fromIntegral x - centerX)

generateSimplePolygon :: Int -> (Int, Int) -> StdGen -> (Polygon, StdGen)
generateSimplePolygon count range gen =
    let (points, nextGen) = generateUniquePoints count range gen
    in (orderPoints points, nextGen)

generatePolygon :: PolygonType -> Int -> (Int, Int) -> StdGen -> (Polygon, StdGen)
generatePolygon polygonType count range gen =
    let (polygon, nextGen) = generateSimplePolygon count range gen
    in if isSimplePolygon polygon && matchesType polygonType polygon
        then (polygon, nextGen)
        else generatePolygon polygonType count range nextGen

matchesType :: PolygonType -> Polygon -> Bool
matchesType Convex = isConvex
matchesType NonConvex = not . isConvex