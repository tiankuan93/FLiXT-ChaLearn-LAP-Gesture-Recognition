% This m-file is main file for running SVM classification. 
% The first step is to load all train-features and test-features. 
% This m-file is for running SVM classification. 
% The train and test features will be loaded first.These features can be 
% downloaded from XXXXX.
% The generated test label will be saved in
% ChaLearn_FLiXT_code/get_predict_file/mat/ directly.


clear all;
clc;

%load train features
load('features/deep_32_train_fet_fc6.mat');
load('features/rgb_32_train_fet_fc6.mat');
load('features/sal_32_train_fet_fc6.mat');
%load test features
load('features/deep_32_test_fet_fc6.mat');
load('features/rgb_32_test_fet_fc6.mat');
load('features/sal_32_test_fet_fc6.mat');
%load train label
load('features/train_all_35878_label_gt.mat');
%create test label. As the labels of test data is unavailable, zeros are employed to
%hold the places of test data labels. 
test_label = zeros(6271,1);

train_fet = (deep_32_train_fet_fc6+rgb_32_train_fet_fc6+sal_32_train_fet_fc6)/3;
test_fet = (deep_32_test_fet_fc6+rgb_32_test_fet_fc6+sal_32_test_fet_fc6)/3;

all_fet = [train_fet;test_fet];
all_lab = [train_all_35878_label_gt;test_label];
train_idx = [1:35878]';
test_idx = [35879:42149]';



[test_predict_label,test_probability]=SVMClassification(all_fet,train_idx,test_idx,all_lab,249);

save('../get_predict_file/mat/test_predict_label.mat','test_predict_label');