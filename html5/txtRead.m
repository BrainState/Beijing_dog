function [txt] = txtRead(fp)
% jiangjian@ion.ac.cn
% 2019-05-23
% read txt from a file: txt, html
fid=fopen(fp);
txt='';
while ~feof(fid)                                      % 判断是否为文件末尾               
    tline=fgetl(fid);                                 % 从文件读行
    txt=[txt,tline];
end
fclose(fid);
end

