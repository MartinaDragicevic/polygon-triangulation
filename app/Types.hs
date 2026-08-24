module Types where

data Point = Point Int Int
    deriving (Show, Eq)

type Polygon = [Point]