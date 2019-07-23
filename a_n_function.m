
function toReturn = a_n_function(n, v, lowerBound, upperBound)
    syms x;
    a_n = @(x) exp((-1/(2*pi*v)) * (1-cos(pi*x))) * cos(n*pi*x);
    toReturn = 2 * double(int(a_n(x), lowerBound, upperBound));
    