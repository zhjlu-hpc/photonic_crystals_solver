
function NO = cube_number(cube,N)


if cube(1) < 1 | cube(2) < 1 | cube(3) < 1 ...
        | cube(1) > N | cube(2) > N | cube(3) > N
    NO = 0;
else
    NO = N*N*(cube(3)-1) + N*(cube(2)-1) +cube(1);
end

end

