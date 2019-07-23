
function toReturn = uDenominator(t, x, v, a_0)
    n = 1;
    sum = 0;
    while(true)
        a_n = a_n_function(n, v, 0, 1);
        bufferSum = sum;
        sum = sum + (a_n * exp(-(n^2)*(pi^2)*v*t) * cos(n*pi*x));
        if(abs(sum - bufferSum) < 0.001)
            break;
        end
        n = n + 1;
    end
    toReturn = a_0 + sum;

    