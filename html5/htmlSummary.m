function [varargout] = htmlSummary(source_fp,varargin)
% summary html files and show
% jiangjian@ion.ac.cn
% 2019-05-31
% input: source_fp, save_folder

%source_fp='K:\EEG_figures\mouse_DSI\figures\Sox2_NMS_20190517';
%save_folder='K:\EEG_figures\mouse_DSI\figures\';
[save_folder,fn]=fileparts(source_fp);
if nargin>1
    save_folder=varargin{1};
end



fps=listFiles(source_fp,'html');
hfp=[save_folder,'\home_',fn,'.html'];
hfp_txt=[save_folder,'\home_txt_',fn,'.html'];
fid=fopen(hfp,'w');
fprintf(fid,'<a href="%s" target="_blank">All Text</a>',hfp_txt);
htmls=htmlList(fid,fps,'figures');
fclose(fid);
fid2=fopen(hfp_txt,'w');
fprintf(fid2,'%s',htmls);
fclose(fid2);
winopen(hfp)

if nargout>0
    varagout{1}=hfp;
end
end

