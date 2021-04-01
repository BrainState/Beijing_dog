
% jiangjian@ion.ac.cn
% 2020-04-21


%% 2020-04-22 -> 04-23, pre
clear,clc
folder_figure='I:\eeg_figures\dog_BeiJing\KLDs-EMG\';
szExpPath='\\10.10.44.152\eeg\dog-M01\20200603';
rs={
    datetime([2020 06 03 7 0 0]),datetime([2020 06 04 7 00 0])
    datetime([2020 06 04 7 0 0]),datetime([2020 06 05 7 00 0])
    datetime([2020 06 05 7 0 0]),datetime([2020 06 06 7 00 0])
    datetime([2020 06 06 7 0 0]),datetime([2020 06 07 7 00 0])
    datetime([2020 06 07 7 0 0]),datetime([2020 06 08 7 00 0])
    datetime([2020 06 08 7 0 0]),datetime([2020 06 09 7 00 0])
    datetime([2020 06 09 7 0 0]),datetime([2020 06 10 7 00 0])
    datetime([2020 06 10 7 0 0]),datetime([2020 06 11 7 00 0])
    datetime([2020 06 11 7 0 0]),datetime([2020 06 12 7 00 0])
    };
info=infoRW(szExpPath);
s200312_KLDs;



%% KLD summary 
clear,clc
fp='I:\eeg_figures\dog_BeiJing\KLDs\';
folder_save='I:\eeg_figures\dog_BeiJing\KLDs\summary\';
files=listFiles(fp,'mat');files=files.files;
divs_abs=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'energy','once'))
        disp(files(i).path)
        load(files(i).path)
        divs_abs(end+1,:)=div_abs;
        dd=dd+1;
        legs{end+1}=['dpre-',num2str(dd)];
    end
end
figure,plot(divs_abs(2:7,:)','lineWidth',3)
legend(legs)
% ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')
printJ(which('s200421_P31_KLDs'),gcf,[folder_save,'200421_pre_drug_KLDs_dn'])

folder_save='I:\eeg_figures\monkey_substance\KLDs\P31\summary\';
fp='I:\eeg_figures\monkey_substance\KLDs\P31\low_dosage\';
files=listFiles(fp,'mat');files=files.files;
divs_abs=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'energy','once'))
        disp(files(i).path)
        load(files(i).path)
        divs_abs(end+1,:)=div_abs;
        dd=dd+1;
        legs{end+1}=['low-',num2str(dd)];
    end
end
figure,plot(divs_abs(:,:)','lineWidth',3)
legend(legs)
ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')
printJ(which('s200421_P31_KLDs'),gcf,[folder_save,'200424_low_dosage_KLDs_dn'])

%% trace view
% 06-07
[b,a]=butter(3,2/(sr/2),'high');
eeg2=filter(b,a,eeg);
figure,plotJ(eeg,sr*3600),xlim([0,24])
figure,plotJ(eeg2,sr*3600),xlim([0,24])
% EMG noise
eg2=eeg2(8.5*sr*3600+1:8.64*sr*3600);
% figure,plotJ(eg2,sr)
% xlim([60,65])
% ylabel('Amplitude (uV)')
% printJ(which('s2000603_dog_KLDs'),gcf)
[p,x]=frequencyShow(eg2,sr);
figure,plot(x,smooth(p,51))

eg2=eeg2(14.6*sr*3600+1:14.74*sr*3600);
% figure,plotJ(eg2,sr)
% ylabel('Amplitude (uV)')
% printJ(which('s2000603_dog_KLDs'),gcf)

[p,x]=frequencyShow(eg2,sr);
hold on
plot(x,smooth(p,51))
xlim([0,100])

hold on
plotJ(eeg2(2e4*sr+1:2.2e4*sr),sr);
hold off
[p,x]=frequencyShow(eeg1(1.6e4*sr+1:1.62e4*sr),sr);
figure,
hold on
plot(x,smooth(p,101))
xlim([0,100])

[p,x]=frequencyShow(eeg1(2e4*sr+1:2.2e4*sr),sr);
% figure
plot(x,smooth(p,101))
xlim([0,100])

%% 2020-08-18 KLDs
clear,clc
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\200814\KLDs-',ch_n,'\'];
szExpPath='\\10.10.44.152\eeg\dog-M01\20200814';
rs={
    %datetime([2020 08 14 13 33 0]),datetime([2020 08 14 15 32 01])
    %datetime([2020 08 14 07 0 0]),datetime([2020 08 15 07 0 01])
    datetime([2020 08 15 07 0 0]),datetime([2020 08 16 07 0 01])
    datetime([2020 08 16 07 0 0]),datetime([2020 08 17 07 0 01])
    datetime([2020 08 17 07 0 0]),datetime([2020 08 18 07 0 01])
    datetime([2020 08 18 07 0 0]),datetime([2020 08 19 07 0 01])
    datetime([2020 08 19 07 0 0]),datetime([2020 08 20 07 0 01])
    datetime([2020 08 20 07 0 0]),datetime([2020 08 21 07 0 01])
    datetime([2020 08 21 07 0 0]),datetime([2020 08 22 07 0 01])  
    };
info=infoRW(szExpPath);
s200312_KLDs;

files=listFiles(folder_figure,'mat');
files=files.files;
divs=[];
for i=3:length(files)
    fp0=files(i).path;
    [~,fn,~]=fileparts(fp0);
    if ~isempty(regexp(fn,'energy', 'once'))
        disp(fn)
        load(fp0)
        divs(:,end+1)=div_abs;
    end    
end

figure,plot(divs)

figure
hold on
plot(divs(:,2:4),'-')
plot(divs(:,[6,7]),'-r')
hold off

% activity
clear,clc
fp='I:\eeg_figures\dog_BeiJing\200814\KLDs-EMG';
files=listFiles(fp,'mat','activity_temperature');files=files.files;
divs_abs=[];
legs={};
dd=0;

for i=3:8
    [~,fn]=fileparts(files(i).path);
    disp(files(i).path)
    load(files(i).path)
    divs_abs(end+1,:)=act2;
    dd=dd+1;
    legs{end+1}=['low-',num2str(dd)];
end
[v,E]=histcounts(act2(end/2+1:end),500);

vs=[];
for i=1:6
    vs(i,:)=histcounts(divs_abs(i,end/2+1:end),E);
end

figureJ,
hold on
x=log10(E(1:end-1));
plot(x,vs(1:3,:)','-k')
plot(x,vs(4:6,:)','-r')
hold off

figureJ,
x=log10(E(1:end-1));
% vs2=log10(vs);
vs2=vs;
hs=[];
hold on
m1=vs2(1:3,:);col='k';
sem_plot;
m1=vs2(4:6,:);col='r';
sem_plot;
tt=[];
for i=1:length(x)
    tt(i)=ttest2(vs(1:3,i),vs(4:6,i));
end
tt(isnan(tt))=0;
hold on
if sum(tt)>0
    plot(x(tt==1),tt(tt==1)*20,'ok','markerFaceColor','k','markerEdgeColor','k','markerSize',6)
end
hold off
xlabel('Activity (log10)')
ylabel('counts')
printJ(which('s2000603_dog_KLDs'),gcf,'K:\EEG_figures\Temp\J2009\J200908_1439_37844')
printJ(which('s2000603_dog_KLDs'),gcf,'K:\EEG_figures\Temp\J2009\J200908_1437_00682')

vs=[];
for i=1:6
    vs(i,:)=histcounts(divs_abs(i,1:end/2),E);
end
figureJ,
x=log10(E(1:end-1));
% vs2=log10(vs);
vs2=vs;
hs=[];
hold on
m1=vs2(1:3,:);col='k';
sem_plot;
m1=vs2(4:6,:);col='r';
sem_plot;
tt=[];
for i=1:length(x)
    tt(i)=ttest2(vs(1:3,i),vs(4:6,i));
end
tt(isnan(tt))=0;
hold on
if sum(tt)>0
    plot(x(tt==1),tt(tt==1)*20,'ok','markerFaceColor','k','markerEdgeColor','k','markerSize',6)
end
hold off
xlabel('Activity (log10)')
ylabel('counts')
printJ(which('s2000603_dog_KLDs'),gcf,'K:\EEG_figures\Temp\J2009\J200908_1439_37844-d')
printJ(which('s2000603_dog_KLDs'),gcf,'K:\EEG_figures\Temp\J2009\J200908_1437_00682-d')


figure,plot(divs_abs(:,:)','lineWidth',3)
legend(legs)
ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')

%% 2020-08-18 alertness
clear,clc
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\200814\alertness\KLDs-',ch_n,'\'];
szExpPath='\\10.10.44.152\eeg\dog-M01\20200814\';
rs={
    datetime([2020 08 14 13 33 0]),datetime([2020 08 14 15 32 01])
    datetime([2020 08 14 07 0 0]),datetime([2020 08 15 07 0 01])
    datetime([2020 08 15 07 0 0]),datetime([2020 08 16 07 0 01])
    datetime([2020 08 16 07 0 0]),datetime([2020 08 17 07 0 01])
    datetime([2020 08 17 07 0 0]),datetime([2020 08 18 07 0 01])
    datetime([2020 08 18 07 0 0]),datetime([2020 08 19 07 0 01])
    datetime([2020 08 19 07 0 0]),datetime([2020 08 20 07 0 01])
    datetime([2020 08 20 07 0 0]),datetime([2020 08 21 07 0 01])
    datetime([2020 08 21 07 0 0]),datetime([2020 08 22 07 0 01])  
    };
info=infoRW(szExpPath);
s200512_day_alertness;
logJ('dataProcess',folder_figure,'dog')


files=listFiles(folder_figure,'mat');
files=files.files;
kss=[];
slper=[];
for i=1:length(files)
    fp0=files(i).path;
    [~,fn,~]=fileparts(fp0);
    if ~isempty(regexp(fn,'all_', 'once'))
        disp(fn)
        load(fp0)
        kss(end+1,:)=ks;
        slper(end+1)=sum(ks(end/2+1:end)<0);
    end
    
end


figure,plot(kss')

figure,plot(kss(2:6,:)')

figure,
bar(slper)

%% sleep stages: alertness to stages
clear,clc

% load  alertness
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\200814\alertness\KLDs-',ch_n,'\'];
save_folder='I:\eeg_figures\dog_BeiJing\200814\alertness\sleep_stages\';
files=listFiles(folder_figure,'mat','all_alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
for i=1:length(files)
    fp=files(i).path;
    load(fp)
    [~,fn]=fileparts(fp);
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
    
    sws=sum(st==-2)/720*100;
    n12=sum(st==-1)/720*100;
    rem=sum(st==-0)/720*100;
    awake=sum(st==1)/720*100;
    str=sprintf('SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%',sws,n12,rem,awake);
    text(10,-2.3,str,'FontSize',18);
    savep=[save_folder,fn];
    printJ(which('s2000603_dog_KLDs'),gcf,savep)
    close all;
end
% logJ('dataProcess',save_folder,'dog')


%% sleep stages: band power
clear,clc
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\200814\alertness\KLDs-',ch_n,'\'];
szExpPath='\\10.10.44.152\eeg\dog-M01\20200814\';
rs={
    datetime([2020 08 14 13 33 0]),datetime([2020 08 14 15 32 01])
    datetime([2020 08 14 07 0 0]),datetime([2020 08 15 07 0 01])
    datetime([2020 08 15 07 0 0]),datetime([2020 08 16 07 0 01])
    datetime([2020 08 16 07 0 0]),datetime([2020 08 17 07 0 01])
    datetime([2020 08 17 07 0 0]),datetime([2020 08 18 07 0 01])
    datetime([2020 08 18 07 0 0]),datetime([2020 08 19 07 0 01])
    datetime([2020 08 19 07 0 0]),datetime([2020 08 20 07 0 01])
    datetime([2020 08 20 07 0 0]),datetime([2020 08 21 07 0 01])
    datetime([2020 08 21 07 0 0]),datetime([2020 08 22 07 0 01])  
    };
info=infoRW(szExpPath);

threshold_SWS=0.0165;
threshold_Light=0.009;
threshold_rem=3e-3; % addiction P8: 3e-3; BMAL1: 1.3e-3 
threshold_act=4e3;

info=infoRW(szExpPath);
s200223_monkey_sleep_stages;

%% 2021-01-02,activity cmp
clear,clc
fp='I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat','activity_temperature');files=files.files;
acts=[];
temps=[];
legs={};
dd=0;
fns={};
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'activity_temperature','once'))
        disp([num2str(dd+1),',',files(i).path])
        fns{end+1}=fn;
        load(files(i).path)
        acts(end+1,:)=act2;
        temps(end+1,:)=temp2;
        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
acts1=log(acts);

figureJ
plot(acts(1:6,:)')

figureJ
plot(acts(7:12,:)')

figure,
vs =violinplot(log10([acts_1',acts_2']), [legs,legs]);

% night locomotion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acts=acts1(:);
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,end/2:end);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,end/2:end);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);



figureJ
hold on
t=acts1(1:6,3060:7380)';
plot(t(:))
t=acts1(7:12,3060:7380)';
plot(t(:))
hold off


figure
hold on
plot(E(1:end-1),cumsum(x1),'k','lineWidth',3)

plot(E(1:end-1),cumsum(x2),'r','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\201120\summary\','locomotion_night'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off

% day locomotion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acts=acts1(:);
acts(acts==-Inf)=7;
E=linspace(min(acts),max(acts),1000);
t=acts1(1:6,1:end/2);
t=t(:);
t(t<8.2)=[];
x1=histcounts(t(:),E);
t=acts1(7:12,1:end/2);
t=t(:);
t(t<8.2)=[];
x2=histcounts(t(:),E);



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

plot(E(1:end-1),cumsum(x2),'k','lineWidth',3)
hold off
xlim([8,13])
xlabel('Locomotion')
ylabel('Cum Loco.')
savep=['I:\eeg_figures\dog_BeiJing\201120\sumamry\','locomotion_day'];
printJ(which('s20210301_dog'),gcf,savep)

figureJ
hold on
plot(E(1:end-1),x1,'r')
plot(E(1:end-1),x11,'r')

plot(E(1:end-1),x2,'k')
plot(E(1:end-1),x21,'k')
hold off



%% 2020-10-16, EMG KLD
% KLDs
clear,clc

szExpPath='\\10.10.44.152\eeg\dog-M01\20201016\Experiment_3';
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\20201016\KLDs-',ch_n,'\'];
rs={
    datetime([2020 10 17 7 0 0]),datetime([2020 10 18 7 00 0])
    datetime([2020 10 18 7 0 0]),datetime([2020 10 19 7 00 0])
    datetime([2020 10 19 7 0 0]),datetime([2020 10 20 7 00 0])
    datetime([2020 10 20 7 0 0]),datetime([2020 10 21 7 00 0])
    datetime([2020 10 21 7 0 0]),datetime([2020 10 22 7 00 0])
    datetime([2020 10 22 7 0 0]),datetime([2020 10 23 7 00 0])
    };
info=infoRW(szExpPath);
eeg_read;

load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1068899_20201017_data.mat')
load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1068899_20201018_data.mat')
load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1068899_20201019_data.mat')

load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1089170_20201017_data.mat')
load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1089170_20201018_data.mat')

ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);

E=linspace(0,0.5,100);
p=histcounts(ps1,E);
figure,plot(E(1:end-1),p)

figure,plotJ(eeg1(1:sr*3600*2),sr)

[b,a]=butter(3,[1,30]/(sr/2),'bandpass');
eeg2=filter(b,a,eeg1);
figure,plotJ(eeg2(1:sr*3600*2),sr)

t=eeg2(1200*sr+1:1300*sr);
t=eeg2(2620*sr+1:2720*sr);
t=eeg2(3190*sr+1:3290*sr);

t=eeg2(6940*sr+1:7040*sr);
t=eeg1(3120*sr+1:3160*sr);

figure,plotJ(t,sr)

figure,frequencyShow(t,sr)
xlim([0,50])

nw=10;% Specify Time-Halfbandwidth Product
len=length(t)/10; % DFT Length Equal to Signal Length
figure,pmtm(t,nw,len,sr);
xlim([0,100])

%% 2020-10-26, KO VS WT, KLD
% KLDs
clear,clc
folder_figure='I:\eeg_figures\dog_BeiJing\20201016\';
szExpPath='\\10.10.44.152\eeg\dog-M01\20201016\Experiment_3';
ch_n='EEG';
rs={
    %datetime([2020 10 17 7 0 0]),datetime([2020 10 18 7 00 0])
    %datetime([2020 10 18 7 0 0]),datetime([2020 10 19 7 00 0])
    datetime([2020 10 19 7 0 0]),datetime([2020 10 20 7 00 0])
    %datetime([2020 10 20 7 0 0]),datetime([2020 10 21 7 00 0])
    %datetime([2020 10 21 7 0 0]),datetime([2020 10 22 7 00 0])
    datetime([2020 10 22 7 0 0]),datetime([2020 10 23 7 00 0])
    };
info=infoRW(szExpPath);
s200312_KLDs;



% KLDs
clear,clc
fp='I:\eeg_figures\dog_BeiJing\20201016\';
folder_save='I:\eeg_figures\dog_BeiJing\KLDs\20201016-summary\';
files=listFiles(fp,'mat','energy');files=files.files;
divs_abs=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'energy','once'))
        disp(files(i).path)
        load(files(i).path)
        divs_abs(end+1,:)=div_abs;
        dd=dd+1;
        legs{end+1}=['dpre-',num2str(dd)];
    end
end
figure,
hs=[];
hold on
t=plot(divs_abs(1:2,:)','lineWidth',3,'color','r');
hs(1)=t(1);
hs(2)=plot(divs_abs(4,:)','lineWidth',3,'color',[0.5,0.1,0.1]);
t=plot(divs_abs(5:6,:)','lineWidth',3,'color','k');
hs(3)=t(1);
hs(4)=plot(divs_abs(8,:)','lineWidth',3,'color',[0.1,0.1,0.1]*5);
hold off
legend(hs,{'KO-L/D','KO-L/L','WT-L/D','WT-L/L'})
% ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')
printJ(which('s2000603_dog_KLDs'),gcf,[folder_save,'KLDs_summary'])

% activity
clear,clc
fp='I:\eeg_figures\dog_BeiJing\20201016\';
folder_save='I:\eeg_figures\dog_BeiJing\KLDs\\20201016-summary\';
files=listFiles(fp,'mat','activity');files=files.files;
divs_abs=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'activity','once'))
        disp(files(i).path)
        load(files(i).path)
        divs_abs(end+1,:)=temp2;
        dd=dd+1;
        legs{end+1}=['dpre-',num2str(dd)];
    end
end
figure,
hs=[];
xt=linspace(0,24,8640);
hold on
t=plot(xt,divs_abs(1:2,:)','lineWidth',3,'color','r');
hs(1)=t(1);
t=plot(xt,divs_abs(3:4,:)','lineWidth',3,'color',[0.5,0.1,0.1]);
hs(2)=t(1);
t=plot(xt,divs_abs(5:6,:)','lineWidth',3,'color','k');
hs(3)=t(1);
t=plot(xt,divs_abs(7:8,:)','lineWidth',3,'color',[0.1,0.1,0.1]*5);
hs(4)=t(1);
hold off
legend(hs,{'KO-L/D','KO-L/L','WT-L/D','WT-L/L'})
% ylim([0,1.6])
% xlim([0,100])
xlim([0,24])
set(gca,'xtick',0:3:24)
xt=0:3:24;
xt=xt+7;xt(xt>24)=xt(xt>24)-24;
set(gca,'xtickLabel',xt)

xlabel('Time (h)')
ylabel('Temperature')
printJ(which('s2000603_dog_KLDs'),gcf,[folder_save,'Temps_summary'])

%% 2020-10-26, KO VS WT, alertness
% alertness
clear,clc
folder_figure='I:\eeg_figures\dog_BeiJing\20201016-alertness\';
szExpPath='\\10.10.44.152\eeg\dog-M01\20201016\Experiment_3';
ch_n='EEG';
rs={
    %datetime([2020 10 17 7 0 0]),datetime([2020 10 18 7 00 0])
    %datetime([2020 10 18 7 0 0]),datetime([2020 10 19 7 00 0])
    datetime([2020 10 19 7 0 0]),datetime([2020 10 20 7 00 0])
    %datetime([2020 10 20 7 0 0]),datetime([2020 10 21 7 00 0])
    %datetime([2020 10 21 7 0 0]),datetime([2020 10 22 7 00 0])
    datetime([2020 10 22 7 0 0]),datetime([2020 10 23 7 00 0])
    };
info=infoRW(szExpPath);
s200512_day_alertness;

% sleep stages: alertness to stages
clear,clc

% load  alertness
ch_n='EEG';
folder_figure='I:\eeg_figures\dog_BeiJing\20201016-alertness\';
save_folder='I:\eeg_figures\dog_BeiJing\20201016-alertness-sleep_stages\';
files=listFiles(folder_figure,'mat','alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
sws=[];n12=[];rem=[];awake=[];
for i=1:length(files)
    fp=files(i).path;
    load(fp)
    [~,fn]=fileparts(fp);
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
    
    sws(i)=sum(st==-2)/720*100;
    n12(i)=sum(st==-1)/720*100;
    rem(i)=sum(st==-0)/720*100;
    awake(i)=sum(st==1)/720*100;
    str=sprintf('SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%',sws(i),n12(i),rem(i),awake(i));
    text(10,-2.3,str,'FontSize',18);
    savep=[save_folder,fn];
    printJ(which('s2000603_dog_KLDs'),gcf,savep)
    close all;
end
% logJ('dataProcess',save_folder,'dog')

figure
hold on
plot(sws(1))
hold off
