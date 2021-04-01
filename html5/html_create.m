
function [] = html_create(save_path,varargin)
%HTML_PIC_CREATE 此处显示有关此函数的摘要
%   此处显示详细说明
% varargin: js_paths,title

%% copy js lib
fp='D:\Codes\HTML5';
folder=fileparts(save_path);
folder=[folder,'/HTML5'];
if ~exist(folder,'dir')
    mkdir(folder);
end
copyfile(fp,folder);

%% prepare js paths
js_paths={};
title='数据显示';
if nargin>1
    js_paths=varargin{1};
end
if nargin>2
    title=varargin{2};
end
js_paths{end+1}='HTML5/picshow.js';
js_paths{end+1}='HTML5/picshow_script.js';

css_paths={'HTML5/css/pic.css'};

%% create html
fid=fopen(save_path,'w');
fprintf(fid,'%s\n','<html>');
fprintf(fid,'%s\n','<head>');
fprintf(fid,'<title>%s</title>\n',title);

for i=1:length(css_paths)
    fprintf(fid,'<link href="%s" rel="stylesheet" />\n',css_paths{i});
end

fprintf(fid,'%s\n','</head>');
fprintf(fid,'%s\n','<body>');

fprintf(fid,'%s\n','<div id="pic_Container">');
fprintf(fid,'%s\n','</div>');

% load 
for i=1:length(js_paths)
    fprintf(fid,'<script src="%s"></script>\n',js_paths{i});
end

fprintf(fid,'%s\n','</body>');
fprintf(fid,'%s\n','</html>');
fclose(fid);
end

