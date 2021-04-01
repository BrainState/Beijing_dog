function [] = matlab2json(matlab_object,save_path,varargin)
%MATLAB2JSON 此处显示有关此函数的摘要
%   此处显示详细说明
% input: varargin=object_name
[a,b,~]=fileparts(save_path);
if ~isempty(a) && ~exist(a,'dir')
    mkdir(a);
end
js=jsonencode(matlab_object);
object_name='var data=';
if nargin>2
    object_name=varargin{1};    
end
fid1=fopen([save_path,'.js'],'w');
fprintf(fid1,'var data=%s;',js);
fclose(fid1);

fid=fopen([save_path,'.html'],'w');
fprintf(fid,'var %s=\n',object_name);
fprintf(fid,'%s',js);
fprintf(fid,'%s',';');
fclose(fid);

% html to show json
html='<html>';
html=[html,"<head>"];
html=[html,"<title>",object_name,"</title>"];
html=[html,"</head>"];
html=[html,"<div><p>this file is used to check the json files (save as js file).</p>"];
html=[html,"<script src='",b,".js'></script>"];
html=[html,"</div"];
html=[html,"<p>The js name is ",object_name,"</p>"];
html=[html,"<p>",datestr(datetime(),'yyyy-mm-dd HH:MM:ss'),"</p>"];
html=[html,"</html>"];

pp=[a,'/',b,'.html'];
if isempty(a)
    pp=[b,'.html'];
end
% disp(pp)
fid=fopen(pp,'w');
fprintf(fid,'%s',html);
fclose(fid);
end

