clear; close all;
n = [];
year = 2000;
D = [];
dt = randi([0,100],[16,4]);
labels = {'January','Februrary','March','April'};

    
    for i = 1:16
        figure()
        D = [D;dt(i,:)];
        pie(dt(i,:),labels)
        colormap([  
                0 0 1;  %// blue
                0,1,1;  %// cyan
                1 0 0;  %// red
                0 1 0;  %// green
                ])
        yi = year+i;
        name = ['pie' num2str(yi-1)];
        n = [n;name];
        title(name)
        fname = [name '.png'];
        saveas(gcf,fname)
    end
    year = yi;


