% This m-file generates mat-files of features according to the fc6 features
% extracted by C3D model.
% 'fc6_file_root' is the directory of .fc6 features extracted by C3D model.
% These .fc6 files can be either genereated by C3D model or download from
% 'feature_size' indicates the number of features. It can be either 35878
% for training features or 6271 for test features.
% 'feature_type' can be either 'rgb','deep' and 'sal' for rgb, depth and
% saliency features.
% The mat-file of features are saved in directory './features/' and will be
% employed for SVM classification.

fclose all;
clc
clear

fc6_file_root = './fc6/'; % the path should be modified to the direct fc6 files' folder. e.g. for deep training data, it will be './fc6/32f_deep_train_fc6_100000/'
feature_size = 35878;
feature_type = 'rgb';

count_not_found = 0;
fet = zeros(1,4096);
for i=1:feature_size
    if mod(i,100)==0
        disp(i);
    end
    name_str=num2str(i);
    for j=1:5-length(name_str)
        name_str = ['0',name_str];
    end
    if exist([fc6_file_root,'/0',name_str,'.fc6'],'file')
        fid = fopen([fc6_file_root,'/0',name_str,'.fc6'],'r');
        [a,n]=fread(fid,5,'int');
        pos = prod(a);
        [b,n]=fread(fid,pos,'float');
        b=b';%特征为横向量
        fet=[fet;b];
        
        
        fclose all;
    else
        count_not_found = count_not_found + 1;
    end
    
end

fet = fet(2:end,:);
request_type = '';
if  feature_size == 35878
    request_type='train';
else if feature_size == 6271
        request_type='test';
    end
end
eval([feature_type,'_32_',request_type,'_fet_fc6','=zeros(',num2str(feature_size),',4096);']);
eval([feature_type,'_32_',request_type,'_fet_fc6','=fet;']);
save(['./features/',feature_type,'_32_',request_type,'_fet_fc6.mat'],[feature_type,'_32_',request_type,'_fet_fc6']); %以对应变量名保存对应mat

