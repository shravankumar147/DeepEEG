function bar_mclr(dt)
figure()
hold on
for i = 1:length(dt)
    h = bar(i,dt(i));
    if i==1
        set(h,'FaceColor','b');
    elseif i==2
        set(h,'FaceColor','cy');
    elseif i==3
        set(h,'FaceColor','r');
    else
        set(h,'FaceColor','g');
    end
end
hold off
end