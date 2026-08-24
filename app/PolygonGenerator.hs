module PolygonGenerator where

import System.Random (StdGen, uniformR)
import Types (Point(..))

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