close all; clear;
load('barpie_data.mat')
n = [];
D = [];

for i = 1:16
    D = [D;dt(i,:)];
    bar_mclr(dt(i,:))
    ylim([0 100])
    ax = gca;
    ax.YGrid = 'on';
    ax.GridAlpha = 1;
    ax.GridColor = 'k';
    ax.XTick = [1 2 3 4];
    ax.XTickLabels = labels;
    ax.XTickLabelRotation = 0;
    yi = year+i;
%     name = ['bar' num2str(yi-1)];
    name = [num2str(yi-1)];
    n = [n;name];
    title(name)
    ax.FontWeight = 'bold';
    ax.FontSize = 14;
    xlabel('Months')
    ylabel('Rain Fall in cm')
    fname = [name '.png'];
    saveas(gcf,fname)
end