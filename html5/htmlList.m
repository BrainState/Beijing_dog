function [htmls] = htmlList(fid,fps,fn)
% transfer the listed htmls into web page
% jiangjian@ion.ac.cn
% 2019-05-22
% input: fps, fid
% demo:
% fp='K:\EEG_figures\mouse_DSI\figures';
% fps=listFiles(fp,'html');
% hfp='K:\EEG_figures\home.html';
% fid=fopen(hfp,'w');
% htmlList(fid,fps,'figures')
% fclose(fid);
% winopen(hfp)

htmls='';
fprintf(fid,'<div style="margin-left:20px;">');
fprintf(fid,'<h4>%s</h4>',fn); 
fns=fieldnames(fps);
if isfield(fps,'files')
    files=fps.files;
    fprintf(fid,'<ol>');
     for j=1:length(files)
         [~,gn]=fileparts(files(j).path);
         fprintf(fid,'<li><a href="%s" target="_blank">%s</a></li>',files(j).path,gn);
         txt=txtRead(files(j).path);
         txt=char(java.lang.String(txt).replaceAll('1000px','100%'));
         htmls=[htmls,'<div class="unit" style="width:500px;border:1px solid black;margin:5px;padding:5px;float:left;word-break: break-all;">',txt,'</div>'];
         
     end  
     fprintf(fid,'<ol>');
end

for i=1:length(fns)
    if ~strcmp('files',fns{i})
        html=htmlList(fid,fps.(fns{i}),fns{i});
        htmls=[htmls,html];
    end
end

fprintf(fid,'</div>');

end

