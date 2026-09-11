module Visualization where

import Triangulation (Triangle)
import Types (Point(..), Polygon)

savePolygonSVG :: FilePath -> Polygon -> Maybe [Triangle] -> IO ()
savePolygonSVG fileName polygon triangles =
    writeFile fileName (polygonToSVG polygon triangles)

polygonToSVG :: Polygon -> Maybe [Triangle] -> String
polygonToSVG polygon triangles =
    unlines $
        [ "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"600\" height=\"600\" viewBox=\"-5 -5 110 110\">"
        , "  <rect x=\"-5\" y=\"-5\" width=\"110\" height=\"110\" fill=\"white\"/>"
        ]
        ++ triangleLines
        ++ [polygonLine]
        ++ map pointCircle polygon
        ++ ["</svg>"]
  where
    triangleLines =
        case triangles of
            Nothing -> []
            Just ts -> map triangleLine ts

    polygonLine =
        "  <polygon points=\"" ++ unwords (map pointText polygon)
        ++ "\" fill=\"none\" stroke=\"black\" stroke-width=\"1\"/>"

pointText :: Point -> String
pointText (Point x y) =
    show x ++ "," ++ show y

pointCircle :: Point -> String
pointCircle (Point x y) =
    "  <circle cx=\"" ++ show x
    ++ "\" cy=\"" ++ show y
    ++ "\" r=\"1.5\" fill=\"red\"/>"

triangleLine :: Triangle -> String
triangleLine (a, b, c) =
    "  <polyline points=\""
    ++ unwords (map pointText [a, b, c, a])
    ++ "\" fill=\"none\" stroke=\"lightgray\" stroke-width=\"0.5\"/>"