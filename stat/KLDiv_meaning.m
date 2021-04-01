
% 

n=1000000;
a=randn(n,1);

hn=hann(20)/sum(hann(20));

figure
j=0;
divs=[];
for d=-7:7
    [~,E]=histcounts([a;a+d],1000);
    y1=histcounts(a,E);
    y2=histcounts(2*a+d,E);        
    m=mean([a;a+d]);
%     if m~=0
%         y1=y1/m;
%         y2=y2/m;
%     end
    y1=conv(y1,hn,'same')+0.01;
    y2=conv(y2,hn,'same')+0.01;
        
     y1=y1/sum(y1);
     y2=y2/sum(y2);
    
     j=j+1;
    x=E(1:end-1);
    div=KLDiv(y1,y2);
    divs(j)=div;
    disp(div)
    
    
    
    subplot(5,3,j)
    hold on
    plot(x,y1)
    plot(x,y2)
    hold off
    
    title(sprintf('div=%.2f',div))
     xlabel(sprintf('¦¤¦Ì=%d',d))
end
print(gcf,'various miu2','-dpdf','-r300')

figure,plot(-7:7,divs)
print(gcf,'various miu-curve2','-dpdf','-r300')
