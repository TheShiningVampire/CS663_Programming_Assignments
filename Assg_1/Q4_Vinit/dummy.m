a = rand(5,5)

% Plot a 3D surface
[X,Y] = meshgrid(1:5, 1:5);

surf(X,Y,a)
