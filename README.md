team name: FLiXT
leader: Yunan Li
other members: Kuan Tian, Yingying Fan, Xin Xu, Rui Li
================================================================================================
brief introduction
Our code can be divided into 4 modules: data pre-processing module, feature extraction module, classification module and prediction generation module, among which the module of feature extraction is implemented based on the C3D model (an extension of Convolutional Neural Network that learning spatiotemporal features) under the caffe framework. The classification module is based on the libsvm toolkit developed by Chih-Jen Lin. Except the feature extraction, all the modules are developed with matlab.
================================================================================================
the directory tree of our code
ChaLearn_FLiXT_code
 |
 |������32f_video_generate (pre-processing,genreating frame number-assigned videos)
 |         |
 |         |��generate_src_video.m ��the file needs executing to generate videos��
 |         |��get_saliency.m   (obtaining saliency videos)
 |         |��saliency.m   (calculating saliency for each frame)
 |         |��sampling.m   (calculating sampling frequency)
 |
 |������C3D-master   (feature extraction, training and extracting based on C3D model)
 |         |
 |         |������data  ��data storage��including 32-frame videos��and the fc6 features files will also be stored here��
 |         |������examples  ��storing the code of training and feature extracting��
 |         |         |������c3d_finetuning  ��train��
 |         |         |       |��IsoGD_deep_finetuning.sh (finetuning with deep data)
 |         |         |       |��IsoGD_RGB_finetuning.sh  (finetuning with RGB data)
 |         |         |       |��IsoGD_sal_finetuning.sh (finetuning with saliency data)
 |         |         |       |...
 |         |         |
 |	   |         |������c3d_feature_extraction (feature extraction)
 |         |                 |��c3d_IsoGD_deep_feature_extraction.sh (extracting features of depth training data)
 |         |                 |��c3d_IsoGD_deep_test_feature_extraction.sh(extracting features of depth testing data)
 |         |                 |��c3d_IsoGD_RGB_feature_extraction.sh (extracting features of RGB training data)
 |         |                 |��c3d_IsoGD_RGB_test_feature_extraction.sh(extracting features of RGB testing data)
 |         |                 |��c3d_IsoGD_sal_feature_extraction.sh (extracting features of saliency training data)
 |         |                 |��c3d_IsoGD_sal_test_feature_extraction.sh(extracting features of saliency testing data)
 |         |                 |...
 |         |��Makefile.config.example��a example of Caffe environment configuration ,it can be modified according to the condition of target computer and generate Makefile.config�� 
 |         |...
 | 
 |������svm classification  ��SVM classification��needing libsvm installed��
 |         |
 |         |��get_fc6.m   ��convert the fc6 features extracted by C3D into .mat format��
 |         |��run_svm.m   ��the file needs executing to start SVM classification��
 |         |��SVMClassification.m   (SVM classifier function)
 |         |��fc6   (directory to store fc6 feature files extracted by C3D��the fc6 file can also be downloaded from "http://pan.baidu.com/s/1hr6ahow")
 |         |��features   (directory to store feature mat-files that generated by get_fc6.m��and can also be download from "http://pan.baidu.com/s/1miCnOwS")
 |         |��libsvm-3.17  (libsvm toolkit)
 |        
 |������get_predict_file  (obtaining prediction file meeting the requirements of submission )
 |         |��get_label_with_mat.m  ��the file needs excuting to generate test_prediction.txt by test_predict_label.mat��
 |         |��test_list.txt  ��the unlabelled list provided by the challenge organizers��
 |         |��mat  ��directory to store mat-file of test label��
 |
 |������ʹ��˵��.txt
 |������readme.txt

================================================================================================
test environment
hardware
	CPU: Intel Core i7-6700 CPU @ 3.40GHz ��8
	RAM: 16GB
	GPU: Nvidia Geforce GTX TITAN X
software
	OS: Windows 7 64-bit
		Linux Ubuntu 14.04 LTS (specific for caffe framework)
	Matlab R2012b +
================================================================================================

execute details
The details of purposes and steps to run of each module are revealed here.
------------------------------------------------------------------------------------------------
 ��data pre-processing module
 As the C3D model for feature extraction requires input videos with the same length (frame numbers), and for a better performance, we make a pre-processing and unify them into 32-frames videos.
 The code of data pre-processing module are located in the directory of ChaLearn_FLiXT_code/32f_video_generate/, and the main file for executing is generate_src_video.m.
 
 Steps
 1. modifying the variable 'root' with the directory of videos that wait for processing (e.g.,assuming the videos for processing is original training data provide by the challenge organizers, whose directory is "C:/IsoGD/IsoGD_phase_1/train/", then the root can be set as it(the subfolders of that directory is folders numbered with 001-180)).
 2. setting the variable 'feature_number' as the numbers of videos (training video corresponding to 35878 and testing data to 6271)
 3. modifying variable 'writePath' with the path to store output 32-frames videos (the RGB, depth and saliency videos are generated in the same time and will be stored in three folders of "train_RGB_32frames_whole","train_deep_32frames_whole" and "train_sal_32frames_whole" (training videos) or "test_RGB_32frames_whole","test_deep_32frames_whole" and "test_sal_32frames_whole" (test videos) under that path).
 * The 32-frames videos are not uploaded since they are enormous (about 30G). The correctness can be verified by running that module and the video can be generated directly.
 
 
------------------------------------------------------------------------------------------------
 ��feature extraction module
 Feature extraction module is implemented by C3D model under caffe framework, it extract feature vectors with 1*4096 dimension. The installation of caffe and C3D model can be referred as "http://caffe.berkeleyvision.org/installation.html" and "http://www.cs.dartmouth.edu/~dutran/c3d/".
 
 The code of feature extraction module is in the directory of ChaLearn_FLiXT_code/C3D-master/. To run this model, the file Makefile.config.example should be modified according to the target computer's condition firstly, and the configuration in line with that computer should be saved as Makefile.config. Then openning the terminal exactly in the current directory, and input 'make' to finish building (If there are problems with 'make', please type 'make clean' to clean already built files first an then try agin).
 
 This module consists of two parts of training and feature extraction.  Before training, it is necessary to ensure all pre-processed 32-frames videos are stored in ChaLearn_FLiXT_code/C3D-master/data/. (The folders named with "train_RGB_32frames_whole","train_deep_32frames_whole" and "train_sal_32frames_whole" (for training videos), "test_RGB_32frames_whole","test_deep_32frames_whole" and "test_sal_32frames_whole" (for test videos) generated by the first module can be copied here directly ).
 
 Steps
 1. When training C3D models, switch the current directory to ChaLearn_FLiXT_code/C3D-master/examples/c3d_finetuning/, and execute the commands below:
    sh IsoGD_deep_finetuning.sh 
����sh IsoGD_RGB_finetuning.sh 
����sh IsoGD_sal_finetuning.sh 
to training the model with depth, RGB and saliency videos respectively.
After the execution of these commands, three model parameter files will be generated in ChaLearn_FLiXT_code/C3D-master/examples/c3d_finetuning/:
    c3d_Deep_32f_finetune_no_meanfile_1st_iter_100000
����c3d_RGB_32f_finetune_no_meanfile_1st_iter_100000
����c3d_sal_32f_finetune_no_meanfile_1st_iter_100000
(These can also be downloaded from "http://pan.baidu.com/s/1qY3YltU",please ensure they are located in ChaLearn_FLiXT_code/C3D-master/examples/c3d_finetuning/ after downloading)
* for the proto parameter setting like batch-size, please consider the condition of target computer and refer the userguide of C3D on "http://www.cs.dartmouth.edu/~dutran/c3d/" to avoid out-of-memory error.
 2. When extracting features,  switch the current directory to ChaLearn_FLiXT_code/C3D-master/examples/c3d_feature_extraction/, and ensure those three model parameter files are located in ChaLearn_FLiXT_code/C3D-master/examples/c3d_finetuning/. Then execute the commands below:
    sh c3d_IsoGD_deep_feature_extraction.sh
    sh c3d_IsoGD_deep_test_feature_extraction.sh
    sh c3d_IsoGD_RGB_feature_extraction.sh
    sh c3d_IsoGD_RGB_test_feature_extraction.sh
    sh c3d_IsoGD_sal_feature_extraction.sh
    sh c3d_IsoGD_sal_test_feature_extraction.sh
 After that, the feature extraction will be processed and then 6 folders will be generated in ChaLearn_FLiXT_code/C3D-master/data/, which are "32f_deep_train_fc6_100000","32f_RGB_train_fc6_100000","32f_sal_train_fc6_100000","32f_deep_test_fc6_100000","32f_RGB_test_fc6_100000", and "32f_sal_test_fc6_100000" to store fc6 feature files of depth, RGB and saliency videos for either training or testing.
------------------------------------------------------------------------------------------------
��classification module
 classification module recognizes and classifies gestures by exploiting the features obtained above. This module classifies by SVM classifer. We employ a combination of 249 binary classifers since SVM is for binary classification.
 The code of classification module is in ChaLearn_FLiXT_code/svm classification/.
 
 Steps
 1. generating features with .mat format by get_fc6.m (i.e. converting the fc6 feature files extracted above into mat-file). Firstly, the variable 'fc6_file_root'in get_fc6.m should be set as the directory of fc6 files (The fc6 files generated by feature extraction module can be copied to the directory 'ChaLearn_FLiXT_code/svm classification/fc6/'. The fc6 files can also be downloaded from "http://pan.baidu.com/s/1hr6ahow", each of the zip-file can be unzipped and saved into 'ChaLearn_FLiXT_code/svm classification/fc6/'(please do not add any folders between them), and the 'fc6_file_root' needs modifying along with it (e.g. for depth training data, ./fc6/32f_deep_train_fc6_100000/ )).
 2. modifying the value of variable 'feature_size'. It can be either 35878 or 6271 for training or testing data, respectively.
 3. modifying the value of variable 'feature_type'. It can be either 'rgb','deep',or 'sal' corresponding to RGB, depth and saliency feature data.
 4. After three steps above, there will be mat-files format as featureType_32_sampleType_fet_fc6.mat (e.g. "rgb_32_train_fet_fc6.mat" corresponding to rgb training data). These features are required by SVM classifer.
 5. The installation of libsvm
 Our SVM is based on the libsvm toolkit developed by Chih-Jen Lin. For more information, please referring "https://www.csie.ntu.edu.tw/~cjlin/libsvm/". Our installation steps are demonstrated as below:
	(1) openning matlab and switching current matlab path to the folder "matlab" in libsvm, i.e. %libsvmpath%/libsvm-3.17/matlab/ (%libsvmpath% is the path of libsvm).
	(2) in the command window of matlab, typing "mex -setup" to set the compiler for generating mex file. Firstly, a prompt shows "Would you like mex to locate installed compilers", typing "y" to confirm, then it will request you to choose a C++ compiler on the target computer (it is "Microsoft Visual C++ 2010 in f:/Program Files (x86)/Microsoft Visual Studio 10.0" for our situation), then typing "y" to confirm your choice (Matlab 2011b+ support Visual Studio to serve as C++ compiler. Please pay attention about the version of matlab and VS).
	(3) typing "make" in the command window of matlab to run the file "make.m". Then waiting for generating ��libsvmread.mexw64������libsvmwrite.mexw64������svmpredict.mexw64�� and ��svmtrain.mexw64��.
	(4) clicking "Set Path" of matlab (it is in the menu bar of ENVIRONMENT for Matlab 2012b), then clicking "Add with Subfolders" in the dialog, choosing the folder of "libsvm-3.17" and confirming it.Then saving and closing the dialog to finish the installation.
 6. executing the main file "run_svm.m". It firstly loads training and testing features for classification (If Step 4 executed correctly, the features are stored in the ChaLearn_FLiXT_code/svm classification/features/. The mat-files of these features can also be downloaded from "http://pan.baidu.com/s/1miCnOwS", and please save them in ChaLearn_FLiXT_code/svm classification/features/. The train label is also stored in this directory.). This step will generate the mat-file of test label, which will be saved in the corresponding path in prediction generation module.
 
------------------------------------------------------------------------------------------------
��prediction generation module
prediction generation module generates test_prediction.txt file that meets the requirement of challenge.
The code of prediction generation module is in ChaLearn_FLiXT_code/get_predict_file/.

The only step for this module is running "get_label_with_mat.m". The variable 'f_unlabel_txt' locates the directory of "test_list.txt" (which is located in the current directory), and then the mat-file of test label (If the classification module executed correctly, this mat-file is generated in ChaLearn_FLiXT_code/get_predict_file/mat/) is loaded. 'f_label_txt' is to locate the output "test_prediction.txt"(default is the current directory). Finally the "test_prediction.txt" to be submitted is generated.

End!