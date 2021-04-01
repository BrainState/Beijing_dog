
% jiangjian@ion.ac.cn
% 2021-01-02
% code2db('s20210102_summary')
% summary of the 
% data from excel: I:\eeg_figures\dog_BeiJing\sleep_stages.xlsx

% 19:00-07:00
clear,clc
awake=[53.3	43.3	48.1	70.3	48.3	44.4
39.4	40.6	43.1	49.2	41.7	48.3
29.7	29.7	29.4	36.1	32.5	25.3
29.2	33.3	31.7	48.9	25.3	27.2
];

sws=[31.7	35	36.7	13.6	28.1	38.1
47.2	45.3	47.2	48.9	48.3	53.9
40	39.2	46.7	38.3	49.2	39.4
55.3	50.8	50.3	33.9	59.2	54.2
];

figure,
hold on
plot(awake(1:3,:)','k','lineWidth',3)
plot(1:6,awake(1:3,:)','ok','markerSize',8)
plot(awake(4,:)','r','lineWidth',3)
plot(1:6,awake(4,:)','or','markerSize',8)
hold off
title('Awake / 19:00-07:00')
ylabel('Awake(%)')
set(gca,'xtick',1:6)
set(gca,'xtickLabel',{'L/D','L/D','L/D','L/L','L/L','L/L'})
printJ(which('s20210102_summary'),gcf,'K:\EEG_figures\Temp\J2101\J210102_1616_28420')

% SWS sleep on night time
figure,
hold on
plot(sws(1:3,:)','k','lineWidth',2)
plot(sws(4,:)','r','lineWidth',2)
hold off
title('SWS / 19:00-07:00')
ylabel('SWS(%)')

% 7:00--19:00
awake=[59.4	71.7	63.1	57.8	70.8	73.9
56.9	61.4	58.1	58.1	58.6	60.6
60.3	66.1	62.2	62.5	59.7	62.8
76.7	72.2	72.2	65.6	69.7	82.2
];
sws=[23.9	13.1	16.1	22.2	15.6	15.8
31.7	31.1	33.6	29.2	31.1	30.8
23.9	20.3	22.2	25.3	23.6	26.9
13.9	20.8	22.2	30	20.6	16.4
];
figure,
hold on
plot(awake(1:3,:)','k','lineWidth',2)
plot(awake(4,:)','r','lineWidth',2)
hold off
title('Awake / 7:00-19:00')
ylabel('Awake(%)')


% SWS sleep on night time
figure,
hold on
plot(sws(1:3,:)','k','lineWidth',2)
plot(sws(4,:)','r','lineWidth',2)
hold off
title('SWS / 7:00-19:00')
ylabel('SWS(%)')

%% fragments
frag=[
    56	51	56	35	56	50
58	50	52	43	41	41
52	49	60	45	48	55
44	35	39	35	41	35
    ];

figure,
hold on
plot(frag(1:3,:)','k','lineWidth',3)
plot(frag(1:3,:)','ok','markerSize',8)
plot(frag(4,:)','r','lineWidth',3)
plot(frag(4,:)','or','markerSize',8)
hold off
title('frag / 19:00-07:00')
ylabel('fragments')
set(gca,'xtick',1:6)
set(gca,'xtickLabel',{'L/D','L/D','L/D','L/L','L/L','L/L'})
ylim([30,70])
printJ(which('s20210102_summary'),gcf,'K:\EEG_figures\Temp\J2101\J210106_1006_30627')


%% activity
clear,clc
fp='I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat','activity_temperature');files=files.files;
acts=[]; actd=[];EX=linspace(3,5.5,50);
temps=[];
legs={};
dd=0;
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'activity_temperature','once'))
        disp([num2str(dd+1),',',files(i).path])
        load(files(i).path)
        acts(end+1,:)=act2;
        pk1=histcounts(log10(act2),EX);
        actd(end+1,:)=pk1;
        
        temps(end+1,:)=temp2;
        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
acts_1=acts;
temps_1=temps;

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
        pk1=histcounts(log10(act2),EX);
        actd(end+1,:)=pk1;
        
        temps(end+1,:)=temp2;
        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
acts_2=acts;
temps_2=temps;

figure,
vs =violinplot(log10([acts_1(7:12,:)',acts_1(1:6,:)',acts_2']));

figure,
vs =violinplot(log10([acts_1(8,:)',acts_1(2,:)',acts_2([2,8],:)']));
title('L/D')
ylabel('log10(Locomotion)')
set(gca,'xtick',1:4)
set(gca,'xtickLabel',{'KO','WT1','WT2','WT3'})
printJ(which('s20210102_summary'),gcf)


% figure when sort by modify time
figure,
vs =violinplot(log10([acts_1(7:12,:)',acts_1(1:6,:)',acts_2([1:2,9,3:4,10,5:6,11,7:8,12],:)']));

figure,
vs =violinplot(log10([acts_1(7:12,:)',acts_1(1:6,:)',acts_2']));

figureJ,
vs =violinplot([temps_1(7:12,:)',temps_1(1:6,:)',temps_2']);
ylabel('Temperature')
set(gca,'xtick',1:24)
set(gca,'xtickLabel',{'KO','KO','KO','KO','KO','KO','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT','WT'})
printJ(which('s20210102_summary'),gcf,'K:\EEG_figures\Temp\J2101\J210107_1405_29537')


actsum=[sum(acts_1'),sum(acts_2')];
figure,plot(actsum)


figureJ,
x=EX(1:end-1);
hold on
plot(x,actd(7:12,:),'r')
plot(x,actd(1:6,:),'k')
plot(x,actd(13:18,:),'g')
plot(x,actd(19:end,:),'b')
hold off

figureJ,
x=EX(1:end-1);
hold on
plot(x,actd(7:9,:),'r')
plot(x,actd(1:3,:),'k')
plot(x,actd(13:15,:),'g')
plot(x,actd(19:21,:),'b')
hold off

figureJ,
x=EX(1:end-1);hs=[];smooth_len=3;
hold on
m1=actd(7:9,:);col='r';sem_plot;
m1=actd(1:3,:);col='k';sem_plot;
m1=actd(13:15,:);col='k';sem_plot;
m1=actd(19:21,:);col='k';sem_plot;
hold off
ylabel('Counts')
xlabel('Locomotions(log10)')
printJ(which('s20210102_summary'),gcf,'K:\EEG_figures\Temp\J2101\J210107_1418_29949')

%% EMG dynamics
clear,clc
fp='I:\eeg_figures\dog_BeiJing\20201016\KLDs-EMG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat','data');files=files.files;
acts=[];
temps=[];
legs={};
dd=0;
pk_emg=[];
E=linspace(-2.5,1,100);
pkd=[];
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'data','once'))
        disp([num2str(dd+1),',',files(i).path])
        load(files(i).path)
        ps1=pkss_cal(eeg1,sr);
        %ps2=pkss_cal(ps1,60);
        pk_emg(end+1,:)=ps1;
        pk1=histcounts(log10(ps1),E);
        pkd(end+1,:)=pk1;

        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
pk_emg_1=pk_emg;

fp='I:\eeg_figures\dog_BeiJing\201120\KLDs_EMG';
folder_save='I:\eeg_figures\dog_BeiJing\201120\summary\';
files=listFiles(fp,'mat','data');files=files.files;
acts=[];
temps=[];
legs={};
dd=0;
pk_emg=[];
for i=1:length(files)
    [~,fn]=fileparts(files(i).path);
    if ~isempty(regexp(fn,'data','once'))
        disp([num2str(dd+1),',',files(i).path])
        load(files(i).path)
        ps1=pkss_cal(eeg1,sr);
        %ps2=pkss_cal(ps1,60);
        pk_emg(end+1,:)=ps1;
        pk1=histcounts(log10(ps1),E);
        pkd(end+1,:)=pk1;
        
        dd=dd+1;
        legs{end+1}=[fn,'-',num2str(dd)];
    end
end
pk_emg_2=pk_emg;

figure,
vs =violinplot(log10([pk_emg_1',pk_emg_2']));

figure,
vs =violinplot([pk_emg_1',pk_emg_2']);

figure,
vs =violinplot(log10([pk_emg_1(8,:)',pk_emg_1(2,:)',pk_emg_2([2,8],:)']));
title('L/D')
ylabel('log10(EMG)')
set(gca,'xtick',1:4)
xlim([0,5])
set(gca,'xtickLabel',{'KO','WT1','WT2','WT3'})
printJ(which('s20210102_summary'),gcf,'K:\EEG_figures\Temp\J2101\J210107_1435_53561')

figureJ,
x=E(1:end-1);hs=[];smooth_len=3;
hold on
m1=pkd(7:9,:);col='r';sem_plot;
m1=pkd(1:3,:);col='k';sem_plot;
m1=pkd(12:14,:);col='k';sem_plot;
m1=pkd(18:20,:);col='k';sem_plot;
hold off
ylabel('Counts')
xlabel('EMG(log10)')
printJ(which('s20210102_summary'),gcf)


figure
hold on
for ani=7:9
    t=pk_emg_1(ani,:);
    t=mean(reshape(t,10,length(t)/10));
    plot(t,acts_1(ani,:),'.r')
end

for ani=1:3
    t=pk_emg_1(ani,:);
    t=mean(reshape(t,10,length(t)/10));
    plot(t,acts_1(ani,:),'.k')
end


for ani=1:3
    t=pk_emg_2(ani,:);
    t=mean(reshape(t,10,length(t)/10));
    plot(t,acts_2(ani,:),'.g')
end

for ani=7:9
    t=pk_emg_2(ani,:);
    t=mean(reshape(t,10,length(t)/10));
    plot(t,acts_2(ani,:),'.b')
end

hold off

