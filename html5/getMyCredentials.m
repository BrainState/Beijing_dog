function [u,p] = getMyCredentials()
prompt = {'Username:', 'Password:'};
defAns = {'',''};
%title = "Credentials needed for " + getParameter(authInfo,'realm');
title='Login';
answer = inputdlg(prompt, title, [1, 60], defAns, 'on');
if isempty(answer)
    u = [];
    p = [];
else
    u = answer{1};
    p = answer{2};
end
end