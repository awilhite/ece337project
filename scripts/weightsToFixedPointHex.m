x = load('matrix.txt')
y = fi(x,fixdt(1,16,8),[],'Nearest','off');
y = fi(y,1,16,8);
y = hex(y);