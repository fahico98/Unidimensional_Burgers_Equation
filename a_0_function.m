
function toReturn = a_0_function(v, lowerBound, upperBound)
    syms x;
    a_0 = @(x) exp((-1/(2*pi*v)) * (1-cos(pi*x)));
    toReturn = double(int(a_0(x), lowerBound, upperBound));