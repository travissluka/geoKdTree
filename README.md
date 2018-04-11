# geoKdTree
Fortran implementation of a geospatial K-d Tree for efficient lookup of closest latitude/longitude points. 

Once a tree has been constructed by providing it with a list of latitude/longitude points (taking O(n log n) time, where n is the number of points), the tree can then be searched for points closest to a given search point in a fast O(log n) time.

The source file contains more detailed usage information.

## Usage:

### Initializing k-d tree
The `kd_init()` subroutine populates a kd-tree with a list of latitude/longitude points ( `lons`, `lats`) and returns a kd-tree object ( `type(kd_root)`) for use in subsequent calls to subroutines searching the tree

```fortran
subroutine kd_init(root, lons, lats)
    type(kd_root), intent(out)  :: root
    !! the root node of our kd-tree, used by kd_search_nnearest and kd_search_radius

    real(dp), intent(in), target :: lats(:)
    !! 1-D array of latitudes.
    
    real(dp), intent(in), target :: lons(:)
    !! 1-D array of longitudes. These can be within any range. Must match the length of lats
```

Once done with a kd-tree, the memory associated with it should be freed by calling `kd_free()` on it.

### Searching the tree
There are two ways to search the tree and retreive points, by a search radius or by the n-neareast. With both methods, distance can be calculated via great circle distances `(exact=.true.)`, or by a euclidean distance (the default) which is faster. Euclidean distances are close enough for most purposes if the search radius is small comapred with the radius of the earth.

#### by search radius
```fortran
subroutine kd_search_radius(root, s_lon, s_lat, s_radius, r_points, r_distance, r_num, exact)
```

`kd_search_radius()` searches for all points within a given radius (`s_radius`) of the search point (`s_lon, s_lat`). The maximum number of points to search for depends on the size of `r_points` and `r_distance`. Once the arrays are full, the subroutine will exit early. The resulting `r_points` is a list of index values pointing to the corresponding array elements of the orginal `lat, lon` used to initial the kdtree. `r_distance` is a corresponding array of distances.
  
#### by n-nearest neighbors
```fortran
subroutine kd_search_nnearest(root, s_lon, s_lat, s_num, r_points, r_distance, r_num, exact)
```
 
 `kd_search_nnearest()` finds the `s_num` neareast points to the given `s_lon, s_lat`.  The variables `r_points`,`r_distance`, and `r_num` have the same meaning as `kd_search_radius()`
 
 ## Example:
 ```fortran
 use kdtree
 
 type(kd_root) :: ll_kdtree
 real, allocatable :: lons(:), lats(:)
 integer, parameter :: s_num = 4
 integer :: r_points(s_num), r_num
 real    :: r_dist(s_num)
 
 ! initialize lons/lats with the model grid
 ...
 
 ! initialize the kd-tree
 call kd_init(ll_kdtree, lons, lats)
 
 ! search the kd-tree to find the 4 grid points closest to my house.
 call kd_search_nnearest(ll_kdtree, -76.58, 34.28, s_num, r_points, r_distance, r_num)
 do i=1,r_num
   print *, "point ", i, "lat: ", lats[r_points[i]], "lon: ", lons[r_points[i]], "distance: ", r_distance[i]
 end do
 
 ! cleanup
 call kd_free(ll_kdtree)
 ```
