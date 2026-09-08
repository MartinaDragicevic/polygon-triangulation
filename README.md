# Polygon Triangulation

Project for the Functional Programming course, implemented in Haskell.

The main goal of the project is to generate random polygons and triangulate them.

The program can generate convex and non-convex polygons in a two-dimensional space. Polygon points have integer coordinates and are generated from a given range. During generation, duplicate points are avoided and the polygon is checked to make sure it is simple, which means that its edges do not intersect.

A point and a polygon are represented as:

```haskell
data Point = Point Int Int

type Polygon = [Point]
```

The requested polygon type is defined with:

```haskell
data PolygonType = Convex | NonConvex
```

Convexity is checked using the orientation of three consecutive points. If all turns have the same direction, the polygon is convex.

Generated points are ordered by their angle around the common center, which gives a suitable order of polygon vertices.

The second part of the project is polygon triangulation. Triangulation means dividing a polygon into triangles.

For convex polygons, a simple fan triangulation is implemented. For the general case, the ear clipping algorithm is used.

The ear clipping algorithm checks three consecutive vertices that can form an ear. If the middle vertex is convex and no other polygon point is inside that triangle, the triangle is added to the result, the middle vertex is removed, and the same process is repeated on the remaining polygon.

When only three vertices are left, they form the last triangle. A polygon with **n** vertices produces **n - 2** triangles.

The algorithm supports both clockwise and counterclockwise vertex order. If the vertices are given in clockwise order, their order is reversed before triangulation.

The project is divided into several files:

- **Types.hs** - basic data types
- **Geometry.hs** - geometric checks
- **PolygonGenerator.hs** - polygon generation
- **Triangulation.hs** - triangulation algorithms
- **Main.hs** - program execution and result output

The program contains fixed examples with predefined seeds for repeatable testing, as well as random examples that can generate different polygons on each run.

To build the project:

```bash
cabal build
```

To run the project:

```bash
cabal run
```

Authors:

Martina Dragičević  
Petar Milanović