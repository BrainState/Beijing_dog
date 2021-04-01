% clear,clc
ts = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server');
% 
fopen(ts);

data = fread(ts, ts.BytesAvailable);
plot(data);
fclose(ts);