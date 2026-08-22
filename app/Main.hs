module Main (main) where

import Triangulation

main :: IO ()
main = print (triangulateConvex ([1, 2, 3, 4, 5] :: [Int]))