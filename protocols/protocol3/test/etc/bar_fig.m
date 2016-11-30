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
    ax.XTick = [1 2 3 4];
    ax.XTickLabels = labels;
    ax.XTickLabelRotation = 45;
    yi = year+i;
    name = ['bar' num2str(yi-1)];
    n = [n;name];
    title(name)
    xlabel('Months')
    ylabel('Rain Fall in cm')
    fname = [name '.png'];
    saveas(gcf,fname)
end