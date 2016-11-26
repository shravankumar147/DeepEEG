%% Rater function::
function [rate] = rater(x,ar,n)
if n==3
    if (x>ar(1,1) && x < ar(3,1))
        rate=1;
    elseif (x>ar(1,2) && x < ar(3,2))
        rate=2;
    else
        rate=3;
    end
elseif n == 2
    if (x>ar(1,1) && x < ar(3,1))
        rate=1;
    else
        rate=2;
    end
else
    rate=1;
    
end
end