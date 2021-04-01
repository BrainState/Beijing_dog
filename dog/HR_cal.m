
% jiangjian@eegion.com
% 2021-03-24
% HR plot

t=0-eeg3;
[b,a]=butter(2,1/(500/2),'high');
t2=filter(b,a,t);
[pks,ind]=findpeaks(t2,'MinPeakProminence',0.05,'MinPeakDistance',200);
del_i=[];
for ii=1:length(pks)
    if pks(ii)<0 || pks(ii)>0.3
        del_i(end+1)=ii;
    end
end
pks(del_i)=[];
ind(del_i)=[];
hrs=diff(ind)/1000;
hrs2=60./hrs;
figureJ,plot(ind(1:end-1)/1000/3600,smooth(hrs2,11))
axis tight
ylabel('Heart rate (/min)')
xlim([0,24])
ylim([50,300])
xt=0:3:24;
xt=xt+0.5;
xtL=xt+10.5;
xtL(xtL>24)=xtL(xtL>24)-24;
set(gca,'xtick',xt)
set(gca,'xtickLabel',xtL)
xlabel('Time (h)')
savep=[save_folder,fn];
printJ(which('s20210301_dog'),gcf,savep)
save([savep,'.mat'],'fn','hrs2')
close all;
