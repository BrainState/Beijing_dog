function resp = Login()
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% cred = matlab.net.http.Credentials('GetCredentialsFcn',@getMyCredentials);
% options = matlab.net.http.HTTPOptions('Credentials',cred);
% req = matlab.net.http.RequestMessage;
% uri = 'http://sleep.cebsit.ac.cn/';
% resp = req.send(uri,options);

fp='C:/matlab/pwd.bin';
if ~exist(fp,'file')
    if ~exist('C:/matlab/','dir')
        mkdir('C:/matlab/');
    end
    
    [u,p]=getMyCredentials();
    t=dbRead_http('users',{'cmdtype','uName','pwd'},{'userLogon',u,p});
    resp=t.vstring;
    
    fid=fopen(fp,'w+');
    fwrite(fid,jsonencode(t),'char');
    %fprintf(fid,jsonencode(t));
    fclose(fid);
else
    fid=fopen(fp,'r');
    txt=fread(fid);
    fclose(fid);
    ds=jsondecode(char(txt)');
    resp=ds.vstring;
end

end
