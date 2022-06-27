# Hotspots
Test work for WiFi Map

<b>Work requirements:</b> <br>
Требуется реализовать на карте кластеризацию точек таким образом чтобы при любом зуме карты отображались кластера. При высоком зуме (ZOOM IN) кластера перестают отображаться и отображаются только точки.

У кластера имеется 4 размера иконки: маленькая и самая большая. Если отображается большая иконка это говорит от том что в этом кластере большое количество точек.

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
