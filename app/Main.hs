module Main (main) where

import Geometry
import Types

main :: IO ()
main = do
    let a = Point 0 0
        b = Point 4 4
        c = Point 0 4
        d = Point 4 0

    let e = Point 0 0
        f = Point 4 0
        g = Point 0 2
        h = Point 4 2

    print (segmentsIntersect a b c d)
    print (segmentsIntersect e f g h)