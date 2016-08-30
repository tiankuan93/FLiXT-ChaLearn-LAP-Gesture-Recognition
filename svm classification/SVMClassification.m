% The function SVMClassification is for obtaining label by training SVM
% classifer. As SVM is usually used as binary classifier, we employ a
% combination of 249 binary classifiers for the final label.
% The input parameters are: img_fet - a matrix of all features(train-features and
% test-features), train_index - the index of train-features in all features matrix, test_index - the
% index of test-features in all feature matrix, img_lab - the label matrix (also 
% indexed by parameter train_index and test_index, and the test labels are
% occupied with zeros), C - the number of classes. 
% The output parameters are: test_label - the output label for test data.
% test_prob - the accuracy of label

function [test_label,test_prob] = SVMClassification(img_fet, train_index, test_index, img_lab, C)   


train_fet = img_fet(train_index,:);
test_fet  = img_fet(test_index,:);



test_label = zeros(size(test_index,1),1);
test_prob = double(zeros(size(test_index,1),1)); 
rej_label = zeros(size(test_index,1),1);
rej_prob = double(ones(size(test_index,1),1))*(-100);

for c=1:C              % C rounds of  binary classification
 %% classification 
    c
    
    train_lab = zeros(length(train_index), 1) -1;     
    train_lab(find(img_lab(train_index)==c))  = 1;    % positive examples

    LRC_model = svmtrain(train_lab,double(train_fet), '-t 0  -c 15');
    [plabel, acc, prob_es] = svmpredict(ones(size(test_index,1),1),double(test_fet), LRC_model);  
    if c==1
        all_plabel = plabel;
        all_es = prob_es;
    else 
        all_plabel = [all_plabel,plabel];
        all_es = [all_es,prob_es];
    end

   test_label(intersect(find(test_prob<prob_es) , find(plabel==1))) = c; 
   test_prob(intersect(find(test_prob<prob_es) , find(plabel==1))) = prob_es(intersect(find(test_prob<prob_es) , find(plabel==1)));
   
   rej_label(find(rej_prob<prob_es))=c;
   rej_prob(find(rej_prob<prob_es))=prob_es(find(rej_prob<prob_es));
   
%    save mydata test_label test_prob plabel prob_es all_plabel all_es rej_label rej_prob


end 
   test_label(test_label==0)=rej_label(test_label==0);
 
end