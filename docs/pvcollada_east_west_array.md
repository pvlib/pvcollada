
# Representing an east-west PV array

An east-west PV array typically mounts rows of modules back-to-back to form a peak, with the two sides at the same tilt, as illustrated in Figure 1.

![East-west array](east-west-array.png)
Credit: GSES (2026)

In PVCollada, a rack is defined as as a co-planar group of modules. Thus, the east side of a row is one rack and the west side is a second rack.
In the COLLADA implementation, the shape of each side of an east-west rack can be defined with one instance of <geometry>, assuming both sides have the same dimensions.
Then, a <node> is created for each side of a row, with the <instance_geometry> property referencing the defined <geometry>. Separate <node> are needed so that the
each side has a unique <id>. Finally, the racks are placed in the visual scene by placing instance of <node> using <translate> and <rotate>.
