close all; clear;
load('barpie_data.mat')
n = [];
D = [];

for i = 1:16
    figure()
    ax = gca;
    D = [D;dt(i,:)];
    p = pie(dt(i,:),labels);
    set(p(2:2:8),'FontSize',14)
    color = [0 0 1; 0,1,1; 1 0 0; 0 1 0];
    colormap(color)
%     colormap([
%         0 0 1;  %// blue
%         0,1,1;  %// cyan
%         1 0 0;  %// red
%         0 1 0;  %// green
%         ])
    yi = year+i;
%     name = ['pie' num2str(yi-1)];
    name = [num2str(yi-1)];
    n = [n;name];
    title(name)
    ax.FontWeight = 'bold';
    ax.FontSize = 12;
    fname = [name '.png'];
    saveas(gcf,fname)
end

