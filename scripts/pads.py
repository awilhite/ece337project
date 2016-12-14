directions = ["N", "W", "S", "E"]
dir_corner = ["NW", "SW", "SE", "NE"]
angles = [0, 90, 180, 270]

f = open("pads.txt", "w")

for i in range(4):
	for x in range(1, 65):
		f.write("Orient: R%s\n" % angles[i])
		f.write("Pad: U%d %s\n" % (i*64 + x, directions[i]))

	for x in range(1, 10):
		f.write("Orient: R%s\n" % angles[i])
		f.write("Pad: FN%d %s PADNC\n" % (x + i*9, directions[i]))

	f.write("Orient: R%s\n" % angles[i])
	f.write("Pad: c0%d %s PADFC\n" % (i, dir_corner[i]))

	f.write("\n");

f.close()