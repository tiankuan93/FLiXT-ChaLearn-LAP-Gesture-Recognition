% This m-file is for obtaining text-file with test label meeting the format
% requirement.
% Firstly, the unlabeled txt file is read as 'f_unlabel_txt', and then the mat-file 
% of predict label obtained by SVM classification is also loaded.
% the final test_prediction text-file is written by variable f_label_txt.

f_unlabel_txt = fopen('test_list.txt');

load('./mat/test_predict_label.mat'); 

f_label_txt = fopen('test_prediction.txt','a');
 
idx = 1;

while ~feof(f_unlabel_txt) 
    tline = fgetl(f_unlabel_txt); 
    tline = [tline, ' ', num2str(test_predict_label(idx))];
    
     fprintf(f_label_txt,'%s\r\n',tline);
     
     idx = idx+1;
end

fclose all;


        