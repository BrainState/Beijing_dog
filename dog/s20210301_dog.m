

% jjhustion@qq.com
% 2021-03-09
% analysis of dog EEG

%% 20210127
% 2021-01-27  --  2021-02-02
clear,clc
szExpPath='\\10.10.44.152\eeg\dog-M01\20210301\20210127\725_032';
rs={
    datetime([2021 01 27 10 30 00]),datetime([2021 01 28 10 30 00])
    datetime([2021 01 28 10 30 00]),datetime([2021 01 29 10 30 00])
    datetime([2021 01 29 10 30 00]),datetime([2021 01 30 10 30 00])
    datetime([2021 01 30 10 30 00]),datetime([2021 01 31 10 30 00])
    datetime([2021 01 31 10 30 00]),datetime([2021 02 01 10 30 00])
    datetime([2021 02 01 10 30 00]),datetime([2021 02 02 10 30 00])
    };
info=infoRW(szExpPath);

ch_n='EEG';
folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_',ch_n,'\'];
s200312_KLDs;

folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\725-alertness-',ch_n,'\'];
s200512_day_alertness;

ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_',ch_n,'\'];
s200312_KLDs;

%% 20210127
% 2021-01-27  --  2021-02-02
clear,clc
szExpPath='\\10.10.44.152\eeg\dog-M01\20210301\20210223_705_32';
rs={
    datetime([2021 02 23 10 30 00]),datetime([2021 02 24 10 30 00])
    datetime([2021 02 24 10 30 00]),datetime([2021 02 25 10 30 00])
    datetime([2021 02 25 10 30 00]),datetime([2021 02 26 10 30 00])
    datetime([2021 02 26 10 30 00]),datetime([2021 02 27 10 30 00])
    datetime([2021 02 27 10 30 00]),datetime([2021 02 28 10 30 00])
    datetime([2021 02 28 10 30 00]),datetime([2021 03 01 10 30 00])
    };
info=infoRW(szExpPath);

ch_n='EEG';
folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_',ch_n,'\'];
s200312_KLDs;

folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\705-alertness-',ch_n,'\'];
s200512_day_alertness;

ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_',ch_n,'\'];
s200312_KLDs;

%% sleep stages: alertness to stages
clear,clc

% load  alertness
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\20210301\705-alertness-EEG\';
folder_save='I:\eeg_figures\dog_BeiJing\20210301\705-alertness_stages\';
files=listFiles(fp,'mat','_alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
SLP=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    st=alertness2stages(ks,threshold_sws,threshold_nrem,threshold_rem);
    figureJ,
    plot(st,'color','k','lineWidth',2)
    xlim([0,720])
    ylim([-2.5,1.5])
    set(gca,'ytick',[-2,-1,0,1])
    set(gca,'ytickLabel',{'SWS','N1/N2','REM','AWAKE'})
    xt=0:720/4:720;xt(1)=1;
    set(gca,'xtick',xt);
    set(gca,'xtickLabel',{'7','13','19','1','7'});
    xlabel('Time (h)')
    
    st=st(1:end/2);
    nn=length(st);
    sws=sum(st==-2)/nn*100;
    n12=sum(st==-1)/nn*100;
    rem=sum(st==-0)/nn*100;
    awake=sum(st==1)/nn*100;
    str=sprintf('SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%',sws,n12,rem,awake);
    SLP(end+1,:)=[sws,n12,rem,awake];
    text(10,-2.3,str,'FontSize',18);
    %savep=[folder_save,fn];
    savep=[folder_save,'day_',fn];
    printJ(which('s201130_dog'),gcf,savep)
    close all;
end


ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\20210301\725-alertness-EEG\';
folder_save='I:\eeg_figures\dog_BeiJing\20210301\725-alertness_stages\';
files=listFiles(fp,'mat','_alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
SLP2=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    st=alertness2stages(ks,threshold_sws,threshold_nrem,threshold_rem);
    figureJ,
    plot(st,'color','k','lineWidth',2)
    xlim([0,720])
    ylim([-2.5,1.5])
    set(gca,'ytick',[-2,-1,0,1])
    set(gca,'ytickLabel',{'SWS','N1/N2','REM','AWAKE'})
    xt=0:720/4:720;xt(1)=1;
    set(gca,'xtick',xt);
    set(gca,'xtickLabel',{'7','13','19','1','7'});
    xlabel('Time (h)')
    
    st=st(1:end/2);
    nn=length(st);
    sws=sum(st==-2)/nn*100;
    n12=sum(st==-1)/nn*100;
    rem=sum(st==-0)/nn*100;
    awake=sum(st==1)/nn*100;
    str=sprintf('SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%',sws,n12,rem,awake);
    SLP2(end+1,:)=[sws,n12,rem,awake];
    text(10,-2.3,str,'FontSize',18);
    %savep=[folder_save,fn];
    savep=[folder_save,'day_',fn];
    printJ(which('s201130_dog'),gcf,savep)
    close all;
end


si=1;
figure,
plot(SLP([7:12,1:6],si))
hold on
plot(SLP([7:12,1:6],si),'or','markerSize',8)
hold off
title('705: 171-Mu,169-WT')
SLP1=SLP([7:12,1:6],:);

figure,plot(SLP2(:,si))
hold on
plot(SLP2(:,si),'or','markerSize',8)
hold off
title('725: 168-Mu,169-WT')

si=4;
delta=1;
figureJ,
hold on
barplot_J(gca,1,SLP1(1:3,si),'r');
barplot_J(gca,2,SLP1(4:6,si),[0.5,0.1,0.1]);

barplot_J(gca,3,SLP2(1:3,si),'r');
barplot_J(gca,4,SLP2(4:6,si),[0.5,0.1,0.1]);

barplot_J(gca,5+delta,SLP1(7:9,si),'k');
barplot_J(gca,6+delta,SLP1(10:12,si),[0.5,0.5,0.5]);

barplot_J(gca,7+delta,SLP2(7:9,si),'k');
barplot_J(gca,8+delta,SLP2(10:12,si),[0.5,0.5,0.5]);
hold off
title('')
ylabel('Awake per (%)')
set(gca,'xtick',[1:4,6:9])
set(gca,'xtickLabel',{'705M-LD','705M-LL','725M-LD','725M-LL','WT07-LD','WT07-LL','WT07-LD','WT07-LL'})
xtickangle(45)
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','awake_per'];
printJ(which('s20210301_dog'),gcf,savep)

%% temp cmp
clear,clc

% load  alertness
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EEG\';
files=listFiles(fp,'mat','_activity_temperature');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
temps1=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    temps1(end+1,:)=temp2;
end
temps1=temps1([7:12,1:6],:); % KO, WT

fp='I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_EEG\';
files=listFiles(fp,'mat','_activity_temperature');
files=files.files;
temps2=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    temps2(end+1,:)=temp2;
end


figureJ
hold on
plot(temps1(1:6,:)','r')
plot(temps1(7:12,:)','k')

plot(temps2(1:6,:)','g')
plot(temps2(7:12,:)','k')
hold off

figureJ
x=1:8640;smooth_len=11;
hs=[];
hold on
m1=temps1(1:3,:);col='r';
sem_plot;
m1=temps2(1:3,:);col=[0.5,0.1,0.1];
sem_plot;
m1=temps1(4:6,:);col='g';
sem_plot;
m1=temps2(4:6,:);col=[0.1,0.5,0.1];
sem_plot;

m1=temps1(7:9,:);col='k';
sem_plot;
m1=temps2(7:9,:);col='k';
sem_plot;

m1=temps1(10:12,:);col=[0.5,0.5,0.5];
sem_plot;
m1=temps2(10:12,:);col=[0.5,0.5,0.5];
sem_plot;

hold off


figure
x=linspace(0,24,8640);smooth_len=11;
hs=[];
hold on
m1=temps1(1:6,:);col='r';
sem_plot;
m1=temps2(1:6,:);col=[0.5,0.1,0.1];
sem_plot;

m1=temps1(7:12,:);col='k';
sem_plot;
m1=temps2(7:12,:);col='k';
sem_plot;

hold off
xlim([0,24])
ylim([30,40])

xt=0:3:24;
xtL=xt+11;
xtL(xtL>24)=xtL(xtL>24)-24;
set(gca,'xtick',xt+0.5)
set(gca,'xtickLabel',xtL)
xlabel('Time (h)')
ylabel('Temperature (¡æ)')
legend(hs,{'705Mu','725Mu','WT107'})
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','temperatures'];
printJ(which('s20210301_dog'),gcf,savep)

%% locomotive activity
clear,clc

% load  alertness
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EEG\';
files=listFiles(fp,'mat','_activity_temperature');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
acts1=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    acts1(end+1,:)=log(act2);
end
acts1=acts1([7:12,1:6],:); % KO, WT

fp='I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_EEG\';
files=listFiles(fp,'mat','_activity_temperature');
files=files.files;
acts2=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    acts2(end+1,:)=log(act2);
end


% night locomotion
acts=[acts1(:);acts2(:)];
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,3060:7380);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,3060:7380);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);

t=acts2(1:6,3060:7380);
t=t(:);
t(t<8.2)=[];
x11=histcounts(t(:),E);
t=acts2(7:12,3060:7380);
t=t(:);
t(t<8.2)=[];
x21=histcounts(t(:),E);

figureJ
hold on
t=acts1(1:6,3060:7380)';
plot(t(:))
t=acts1(7:12,3060:7380)';
plot(t(:))
hold off


figure
hold on
plot(E(1:end-1),cumsum(x1),'r','lineWidth',3)
plot(E(1:end-1),cumsum(x11),'r','lineWidth',3)

plot(E(1:end-1),cumsum(x2),'k','lineWidth',3)
plot(E(1:end-1),cumsum(x21),'k','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','locomotion_night'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off

% day locomotion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acts=[acts1(:);acts2(:)];
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);

t=acts2(1:6,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x11=histcounts(t(:),E);
t=acts2(7:12,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x21=histcounts(t(:),E);

figureJ
hold on
t=acts1(1:6,3060:7380)';
plot(t(:))
t=acts1(7:12,3060:7380)';
plot(t(:))
hold off


figure
hold on
plot(E(1:end-1),cumsum(x1),'r','lineWidth',3)
plot(E(1:end-1),cumsum(x11),'r','lineWidth',3)

plot(E(1:end-1),cumsum(x2),'k','lineWidth',3)
plot(E(1:end-1),cumsum(x21),'k','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','locomotion_day'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off

%% EMG activity
clear,clc

% load  alertness
fp='I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EMG\';
save_folder='I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EMG-HR\';
files=listFiles(fp,'mat','_energy');
files=files.files;
acts1=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    %acts1(end+1,:)=log(eeg3);    
    HR_cal;    
end
%acts1=acts1([7:12,1:6],:); % KO, WT

fp='I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_EMG\';
save_folder='I:\eeg_figures\dog_BeiJing\20210301\725-KLDs_EMG-HR\';
files=listFiles(fp,'mat','_energy');
files=files.files;
acts2=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    %acts2(end+1,:)=log(act2);
    HR_cal;  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EMG\animal-m_1068898-2021022310_energy.mat')
figureJ,plot(0-eeg3(1:500*1000))
figureJ,plot(eeg3(end/2+1:end))

t=0-eeg3(1:500*1000);

t=0-eeg3;
% t=smooth(t,11);


% filter
[b,a]=butter(2,1/(500/2),'high');
t2=filter(b,a,t);

[pks,ind]=findpeaks(t2,'MinPeakProminence',0.05,'MinPeakDistance',200);

figureJ,plot(t2)
hold on
plot(ind,pks,'or')
hold off

del_i=[];
for i=1:length(pks)
    if pks(i)<0 || pks(i)>0.3
        del_i(end+1)=i;
    end
end
pks(del_i)=[];
ind(del_i)=[];

hrs=diff(ind)/1000;
hrs2=60./hrs;
figure,plot(hrs2)
[c,E]=histcounts(hrs);
figure,plot(E(1:end-1),c)

figureJ,plot(ind(1:end-1)/1000/3600,smooth(hrs2,11))
axis tight
ylabel('Heart rate (/min)')
xlim([0,24])
xt=0:3:24;
xt=xt+0.5;
xtL=xt+10.5;
xtL(xtL>24)=xtL(xtL>24)-24;
set(gca,'xtick',xt)
set(gca,'xtickLabel',xtL)
xlabel('Time (h)')
savep=['I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EMG-HR\','animal-m_1068898-2021022310_energy'];
printJ(which('s20210301_dog'),gcf,savep)

load('I:\eeg_figures\dog_BeiJing\20210301\705-KLDs_EEG\animal-m_1089169-2021022310_energy.mat')
figureJ,plot(eeg3(1:500*1000))
figureJ,plot(eeg3(end/2+1:end))


% night locomotion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acts=[acts1(:);acts2(:)];
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,3060:7380);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,3060:7380);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);

t=acts2(1:6,3060:7380);
t=t(:);
t(t<8.2)=[];
x11=histcounts(t(:),E);
t=acts2(7:12,3060:7380);
t=t(:);
t(t<8.2)=[];
x21=histcounts(t(:),E);

figureJ
hold on
t=acts1(1:6,3060:7380)';
plot(t(:))
t=acts1(7:12,3060:7380)';
plot(t(:))
hold off


figure
hold on
plot(E(1:end-1),cumsum(x1),'r','lineWidth',3)
plot(E(1:end-1),cumsum(x11),'r','lineWidth',3)

plot(E(1:end-1),cumsum(x2),'k','lineWidth',3)
plot(E(1:end-1),cumsum(x21),'k','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','locomotion_night'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off

% day locomotion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acts=[acts1(:);acts2(:)];
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);

t=acts2(1:6,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x11=histcounts(t(:),E);
t=acts2(7:12,[1:3060,7380:8640]);
t=t(:);
t(t<8.2)=[];
x21=histcounts(t(:),E);

figureJ
hold on
t=acts1(1:6,3060:7380)';
plot(t(:))
t=acts1(7:12,3060:7380)';
plot(t(:))
hold off


figure
hold on
plot(E(1:end-1),cumsum(x1),'r','lineWidth',3)
plot(E(1:end-1),cumsum(x11),'r','lineWidth',3)

plot(E(1:end-1),cumsum(x2),'k','lineWidth',3)
plot(E(1:end-1),cumsum(x21),'k','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\20210301\sumamry\','locomotion_day'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off
