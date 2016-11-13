%% Rater function::
function [rate] = rater(x)
%%
x1 = [487, 550];
x2 = [575, 635];
x3 = [660 720];
x4 = [748 807];
x5 = [833 895];
%%
if (x >= min(x1) && x<=max(x1))
    rate = 1;
elseif (x >= min(x2) && x<=max(x2))
    rate =2;
elseif (x >= min(x3) && x<=max(x3))
    rate =3;
elseif (x >= min(x4) && x<=max(x4))
    rate =4;
elseif (x >= min(x5) && x<=max(x5))
    rate =5;
end
end