% animation of radiation propagation through the entire DOE system

W = normalize_field(resizeimage(Test(:,:,randi([1 size(Test,3)])),N,spixel,pixel));
score = recognize(propagation(W, z(2)-z(1), U), Propagations, DOES, MASK, is_max);
score = score/sum(score)*100;

fig = figure;
imagesc([-B B], [-B B], abs(W));
title(['z = ' num2str(z(1)) ' mm']);
pause(3);
h = (z(end)-z(1))/200;
for zone=1:length(z)-1
    for zz = z(zone):h:z(zone+1)
        imagesc([-B B], [-B B], abs(propagation(W, zz - z(zone), U)));
        title(['z = ' num2str(zz*1000) ' mm']);
        pause(0.05);
    end
    W = propagation(W, z(zone+1)-z(zone), U);
    if zone ~= length(z)-1
        W = W.*DOES(:,:,zone);
    end
end

if exist('coords', 'var') == 1
    hold on;
    xx = [-1 -1  1  1 -1]*G_size_x/2;
    yy = [ 1 -1 -1  1  1]*G_size_y/2;
    for nt=1:ln
        plot(xx+coords(nt,1), yy+coords(nt,2), 'color', [1 1 1]);
        text(coords(nt, 1), coords(nt, 2)-G_size_y/2*1.5, sprintf('%.2f%%', score(nt)), ...
                        'fontsize', 14, 'HorizontalAlignment', 'center', 'color', [1 1 1]);
    end
end

pause(6);
close(fig);

clearvars fig zone zz W nt xx yy score h;
