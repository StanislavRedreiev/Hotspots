# Hotspots
Test work for WiFi Map

<b>Work requirements:</b> <br>
Cluster points on the map in such a way that clusters are displayed at any zoom level. At high zoom levels (ZOOM IN), clusters disappear, and only individual points are shown.

Clusters have four different icon sizes: small to the largest. If a large icon is displayed, it indicates that the cluster contains a substantial number of points.

<b>Rules and module description:</b> <br>
There are 4 sizes of a cluster element depending on the number of elements inside.

| Point count | Cluster size |
| ----------- | -----------  |
| < 10        | size 1       |
| 10 ..< 50   | size 2       |
| 50 ..< 100  | size 3       |
| > 100       | size 4       |

<b>Example</b> <br>
<img src="/hotspots_map_example.png" width="400" />
