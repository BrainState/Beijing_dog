
% jiangjian@ion.ac.cn
% 2020-11-30
% 

%% 2020-11-21£¬KLDs and alertness
clear,clc
szExpPath='\\10.10.44.152\eeg\dog-M01\20201120';
rs={
    %datetime([2020 11 21 7 00 00]),datetime([2020 11 22 7 00 00])
    %datetime([2020 11 22 7 00 00]),datetime([2020 11 23 7 00 00])
    datetime([2020 11 23 7 00 00]),datetime([2020 11 24 7 00 00])
    %datetime([2020 11 24 7 00 00]),datetime([2020 11 25 7 00 00])
    %datetime([2020 11 25 7 00 00]),datetime([2020 11 26 7 00 00])
    datetime([2020 11 26 7 00 00]),datetime([2020 11 27 7 00 00])
    };
info=infoRW(szExpPath);
ch_n='EEG';
folder_figure=['I:\eeg_figures\dog_BeiJing\201120\KLDs_',ch_n,'\'];
s200312_KLDs;

clear,clc
ch_n='EEG';
folder_figure=['I:\eeg_figures\dog_BeiJing\201120\alertness-',ch_n,'\'];
szExpPath='\\10.10.44.152\eeg\dog-M01\20201120';
rs={
    %datetime([2020 11 21 7 00 00]),datetime([2020 11 22 7 00 00])
    %datetime([2020 11 22 7 00 00]),datetime([2020 11 23 7 00 00])
    datetime([2020 11 23 7 00 00]),datetime([2020 11 24 7 00 00])
    %datetime([2020 11 24 7 00 00]),datetime([2020 11 25 7 00 00])
    %datetime([2020 11 25 7 00 00]),datetime([2020 11 26 7 00 00])
    datetime([2020 11 26 7 00 00]),datetime([2020 11 27 7 00 00])
    };
info=infoRW(szExpPath);
s200512_day_alertness;

%% 2020-11-21£¬EMG dynamics
clear,clc
szExpPath='\\10.10.44.152\eeg\dog-M01\20201120';
rs={
    datetime([2020 11 21 7 00 00]),datetime([2020 11 22 7 00 00])
    datetime([2020 11 22 7 00 00]),datetime([2020 11 23 7 00 00])
    datetime([2020 11 23 7 00 00]),datetime([2020 11 24 7 00 00])
    datetime([2020 11 24 7 00 00]),datetime([2020 11 25 7 00 00])
    datetime([2020 11 25 7 00 00]),datetime([2020 11 26 7 00 00])
    datetime([2020 11 26 7 00 00]),datetime([2020 11 27 7 00 00])
    };
info=infoRW(szExpPath);
ch_n='EMG';
folder_figure=['I:\eeg_figures\dog_BeiJing\201120\KLDs_',ch_n,'\'];
eeg_read;

clear,clc
pk_emg=[];
load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1089170_20201018_data.mat')
ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);pk_emg(end+1,:)=ps2;
E=linspace(0,0.5,200);
pk1=histcounts(ps1,E);

load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1089170_20201017_data.mat')
ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);pk_emg(end+1,:)=ps2;
E=linspace(0,0.5,200);
pk2=histcounts(ps1,E);



load('I:\eeg_figures\dog_BeiJing\201120\KLDs_EMG\animal_m_1068898_20201121_data.mat')
ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);pk_emg(end+1,:)=ps2;
E=linspace(0,0.5,200);
pw1=histcounts(ps1,E);

load('I:\eeg_figures\dog_BeiJing\201120\KLDs_EMG\animal_m_1089171_20201121_data.mat')
ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);pk_emg(end+1,:)=ps2;
E=linspace(0,0.5,200);
pw2=histcounts(ps1,E);

load('I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG\animal_m_1068899_20201018_data.mat')
ps1=pkss_cal(eeg1,sr);
ps2=pkss_cal(ps1,60);pk_emg(end+1,:)=ps2;
E=linspace(0,0.5,200);
pw3=histcounts(ps1,E);

figure,
vs =violinplot(pk_emg', {'ko','ko','WT','WT','WT'});

figure,
hold on
plot(E(1:end-1),pk1,'color','r')
plot(E(1:end-1),pk2,'color','r')
plot(E(1:end-1),pw1,'color','k')
plot(E(1:end-1),pw2,'color','k')
plot(E(1:end-1),pw3,'color','b')
hold off

figure,plotJ(eeg1(1:sr*3600*2),sr)

[b,a]=butter(3,[0.1,30]/(sr/2),'bandpass');
eeg2=filter(b,a,eeg1);
figure,plotJ(eeg2(1:sr*3600*3),sr)

t=eeg2(8700*sr+1:8800*sr);
figure,plotJ(t,sr)

figure,frequencyShow(t,sr)
xlim([0,50])

nw=10;% Specify Time-Halfbandwidth Product
len=length(t)/10; % DFT Length Equal to Signal Length
figure,pmtm(t,nw,len,sr);
xlim([0,100])

%% 2021-01-02,activity cmp
clear,clc
fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EEG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat','activity_temperature');files=files.files;
acts=[];
temps=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'activity_temperature','once'))
        disp([num2str(dd+1),',',files(i).path])
        load(files(i).path)
        acts(end+1,:)=act2;
        temps(end+1,:)=temp2;
        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
acts_2=acts;

figure
plot(acts')

figure,
vs =violinplot(log10(acts_2'), legs);


%% KLD summary 
clear,clc
fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EEG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat');files=files.files;
divs_abs=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'energy','once'))
        disp([num2str(dd+1),',',files(i).path])
        load(files(i).path)
        divs_abs(end+1,:)=div_abs;
        dd=dd+1;
        legs{end+1}=['dpre-',num2str(dd)];
    end
end
divs_abs=divs_abs([1,2,9,3,4,10,5,6,11,7,8,12],:);
figure,
hold on
plot(divs_abs(1:3,:)','lineWidth',3,'color','k')
plot(divs_abs(4:6,:)','lineWidth',3,'color',[0,0,0]+0.5)

plot(divs_abs(7:9,:)','lineWidth',3,'color','r')
plot(divs_abs(10:12,:)','lineWidth',3,'color',[0.5,0.1,0.1])
hold off
legend(legs)
% ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')


figure,
x=1:125;
hs=[];
smooth_len=3;
hold on
m1=divs_abs(1:2,:);col=[0,0,0];sem_plot;
m1=divs_abs(3:4,:);col=[0,0,0]+0.5;sem_plot;
tt=[];
for i=1:125
    tt(i)=ttest2(divs_abs(5:6,i),divs_abs(7:8,i));
end
if sum(tt)>0
    plot(x(tt==1),tt(tt==1)*0.55,'ok','markerFaceColor','k','markerSize',8)
end
hold off
legend(hs,{'169-L/D','169-L/L'})
% ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')
ylim([0,0.6])
printJ(which('s200421_P31_KLDs'),gcf,[folder_save,'169_KLDs_dn'])

figure,
x=1:125;
hs=[];
smooth_len=3;
hold on
m1=divs_abs(5:6,:);col=[0,0,0];sem_plot;
m1=divs_abs(7:8,:);col=[0,0,0]+0.5;sem_plot;
tt=[];
for i=1:125
    tt(i)=ttest2(divs_abs(5:6,i),divs_abs(7:8,i));
end
if sum(tt)>0
    plot(x(tt==1),tt(tt==1)*0.55,'ok','markerFaceColor','k','markerSize',8)
end
hold off
legend(hs,{'172-L/D','172-L/L'})
% ylim([0,1.6])
xlim([0,100])
xlabel('Frequency (Hz)')
ylabel('KLD')
ylim([0,0.6])
printJ(which('s200421_P31_KLDs'),gcf,[folder_save,'172_KLDs_dn'])

%% sleep stages: alertness to stages
clear,clc

% load  alertness
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\201120\alertness-EEG\';
folder_save='I:\eeg_figures\dog_BeiJing\201120\alertness_stages\';
files=listFiles(fp,'mat','_alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
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
    text(10,-2.3,str,'FontSize',18);
    %savep=[folder_save,fn];
    savep=[folder_save,'day_',fn];
    printJ(which('s201130_dog'),gcf,savep)
    close all;
end

clc
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\201120\alertness-EEG\';
fp='I:\eeg_figures\dog_BeiJing\20201016-alertness\';
folder_save='I:\eeg_figures\dog_BeiJing\201120\alertness_stages\';
files=listFiles(fp,'mat','_alertness');
files=files.files;
threshold_sws=-0.4;
threshold_nrem=0;
threshold_rem=0.4;
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    st=alertness2stages(ks,threshold_sws,threshold_nrem,threshold_rem);
    
    st1=st;
    nn=length(st1);
    sws=sum(st1==-2)/nn*100;
    n12=sum(st1==-1)/nn*100;
    rem=sum(st1==-0)/nn*100;
    awake=sum(st1==1)/nn*100;
    fprintf('%s-24h: SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%\n',fn,sws,n12,rem,awake);
    fprintf('%.1f\t %.1f\t  %.1f\t  %.1f\n',sws,n12,rem,awake);  
    fr=diff(st1);
    frn=sum(fr>0); % number of fragments
    fprintf('fragments: %d\n',frn); 
    
    st1=st(1:end/2);
    nn=length(st1);
    sws=sum(st1==-2)/nn*100;
    n12=sum(st1==-1)/nn*100;
    rem=sum(st1==-0)/nn*100;
    awake=sum(st1==1)/nn*100;
    fprintf('%s-Day: SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%\n',fn,sws,n12,rem,awake);
    fprintf('%.1f\t %.1f\t  %.1f\t  %.1f\n',sws,n12,rem,awake);
    fr=diff(st1);
    frn=sum(fr>0); % number of fragments
    fprintf('fragments: %d\n',frn); 
    
    st1=st(end/2+1:end);
    nn=length(st1);
    sws=sum(st1==-2)/nn*100;
    n12=sum(st1==-1)/nn*100;
    rem=sum(st1==-0)/nn*100;
    awake=sum(st1==1)/nn*100;
    fprintf('%s-Night: SWS-%.1f%%, N1/2-%.1f%%, REM-%.1f%%, AWAKE-%.1f%%\n',fn,sws,n12,rem,awake);
    fprintf('%.1f\t %.1f\t  %.1f\t  %.1f\n',sws,n12,rem,awake);
    fr=diff(st1);
    frn=sum(fr>0); % number of fragments
    fprintf('fragments: %d\n\n',frn); 
end


%% activity summary
% activity
clear,clc
fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EEG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
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
legend(hs,{'169-L/D','169-L/L','172-L/D','172-L/L'})
% ylim([0,1.6])
% xlim([0,100])
xlim([0,24])
set(gca,'xtick',0:3:24)
xt=0:3:24;
xt=xt+7;xt(xt>24)=xt(xt>24)-24;
set(gca,'xtickLabel',xt)

xlabel('Time (h)')
ylabel('Temperature')
ylim([30,40])
printJ(which('s2000603_dog_KLDs'),gcf,[folder_save,'Temps_summary'])

%% activity
clear,clc

% load  alertness
ch_n='EEG';
fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EEG\';
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
fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EMG\';
save_folder='I:\eeg_figures\dog_BeiJing\201120\KLDs_EMG-HR\';
files=listFiles(fp,'mat','_data');
files=files.files;
acts1=[];
for i=1:length(files)
    fp0=files(i).path;
    load(fp0)
    [~,fn]=fileparts(fp0);
    %acts1(end+1,:)=log(eeg3);   
    eeg3=eeg1;
    HR_cal;    
end


%% sleep stages
figure,
hold on
barplot_J(gca,1,[4.9	3.8	4.3	3.3	3.8	3.1],'k');
barplot_J(gca,2,[1.8,1.3],'r');
hold off
set(gca,'xtick',[1,2])
set(gca,'xtickLabel',{'WT','KO'})
ylabel('REM Per. (%)')
printJ(which('s201130_dog'),gcf,[folder_save,'REM_percentages'])

[h,p]=ttest2([4.9	3.8	4.3	3.3	3.8	3.1],[1.8,1.3]);

AWAKE_per=[56.4	48.2	45	52.9
57.5	51	47.9	52.8
55.6  50.6 45.8  51.9
64	53.6	49.3	57.2
59.6	50.1	46.1	47.5
59.2   54.4   44.0  54.7
];
% col is a single animal

figure
hs=[];
hold on
for i=1:3
    hs(1)=plot(AWAKE_per(:,i),'lineWidth',3,'color','k');
    plot(AWAKE_per(:,i),'ok','MarkerSize',8)
end
for i=4
    hs(2)=plot(AWAKE_per(:,i),'lineWidth',3,'color','r');
    plot(AWAKE_per(:,i),'or','MarkerSize',8)
end
hold off
set(gca,'xtick',1:6)
xlim([0.5,6.5])
set(gca,'xtickLabel',{'L/D','L/D','L/D','L/L','L/L','L/L'})
ylabel('AWAKE Per. (%)')
ylim([40,70])
printJ(which('s201130_dog'),gcf,[folder_save,'AWAKE_percentages'])

clc
for i=[1,2,4]
    [h,p]=ttest2(AWAKE_per(:,i),AWAKE_per(:,3))
end



