module PolygonGenerator where

import Data.List (sortOn)
import System.Random (StdGen, uniformR)
import Types (Point(..), Polygon)

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
generateUniquePoints count range gen = generate count [] gen
  where
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