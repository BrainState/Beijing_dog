function [txt] = txtRead(fp)
% jiangjian@ion.ac.cn
% 2019-05-23
% read txt from a file: txt, html
fid=fopen(fp);
txt='';
while ~feof(fid)                                      % �ж��Ƿ�Ϊ�ļ�ĩβ               
    tline=fgetl(fid);                                 % ���ļ�����
    txt=[txt,tline];
end
fclose(fid);
end

