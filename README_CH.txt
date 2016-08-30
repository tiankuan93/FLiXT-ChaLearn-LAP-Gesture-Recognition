组名：FLiXT
组长：李宇楠
成员：田宽 范莹莹 徐昕 李锐
================================================================================================
概要说明
我们的代码可分为四个模块：数据预处理模块，特征提取模块，分类模块和预测文件生成模块。其中特征提取是利用深度学习技术在caffe平台下，通过C3D模型（一种三维卷积神经网络）实现的，分类模块则是基于Chih-Jen Lin开发的libsvm实现的。除特征提取模块，其余模块均基于matlab开发实现。
================================================================================================
代码目录树
ChaLearn_FLiXT_code
 |
 |———32f_video_generate (数据预处理，生成指定帧数的视频)
 |         |
 |         |—generate_src_video.m （需要运行文件）
 |         |—get_saliency.m   (获取saliency视频)
 |         |—saliency.m   (调用的saliency求取方法)
 |         |—sampling.m   (确定采样频率)
 |
 |———C3D-master   (特征提取，基于C3D模型实现训练和特征提取)
 |         |
 |         |———data  （存放数据，包括处理得到的32帧数据，生成的fc6特征文件也会存储在这里）
 |         |———examples  （训练模型和特征提取代码）
 |         |         |———c3d_finetuning  （模型的训练）
 |         |         |       |—IsoGD_deep_finetuning.sh (对depth数据进行fine tune)
 |         |         |       |—IsoGD_RGB_finetuning.sh  (对rgb数据进行fine tune)
 |         |         |       |—IsoGD_sal_finetuning.sh (对saliency数据进行fine tune)
 |         |         |       |...
 |         |         |
 |	   |         |———c3d_feature_extraction (特征提取)
 |         |                 |—c3d_IsoGD_deep_feature_extraction.sh (提取depth训练样本特征)
 |         |                 |—c3d_IsoGD_deep_test_feature_extraction.sh(提取depth测试样本特征)
 |         |                 |—c3d_IsoGD_RGB_feature_extraction.sh (提取rgb训练样本特征)
 |         |                 |—c3d_IsoGD_RGB_test_feature_extraction.sh(提取rgb测试样本特征)
 |         |                 |—c3d_IsoGD_sal_feature_extraction.sh (提取saliency训练样本特征)
 |         |                 |—c3d_IsoGD_sal_test_feature_extraction.sh(提saliency测试样本特征)
 |         |                 |...
 |         |—Makefile.config.example（Caffe 环境配置样例文件，可根据目标机情况自行设置并生成Makefile.config） 
 |         |...
 | 
 |———svm classification  （SVM分类，需安装libsvm）
 |         |
 |         |—get_fc6.m   (将通过C3D模型提取的特征转换为mat格式)
 |         |—run_svm.m   (SVM分类需要运行的文件)
 |         |—SVMClassification.m   (SVM分类函数)
 |         |—fc6   (存放C3D模型提取的特征fc6文件的目录，fc6文件可由C3D生成或直接于http://pan.baidu.com/s/1hr6ahow下载)
 |         |—features   (存放转换的特征mat文件，这些文件可由get_fc6.m生成或直接下载自http://pan.baidu.com/s/1miCnOwS)
 |         |—libsvm-3.17  (libsvm软件包)
 |        
 |———get_predict_file  (获取最终满足要求的test_prediction文件)
 |         |—get_label_with_mat.m  (通过test_predict_label.mat生成test_prediction.txt)
 |         |—test_list.txt  （比赛提供的未标签list）
 |         |—mat  （存放SVM分类得到test的标签mat文件）
 |
 |———使用说明.txt
 |———readme.txt

================================================================================================
测试环境
硬件
  CPU：Intel Core i7-6700 CPU @ 3.40GHz ×8
  内存：16G
  GPU：Nvidia Geforce GTX TITAN X
软件：
  Windows 7 64-bit
  Linux Ubuntu 14.04 LTS (针对caffe平台)
  Matlab R2012b及以上
================================================================================================

具体运行步骤
以下将分模块具体说明每个模块的用途及相关代码的运行步骤。
------------------------------------------------------------------------------------------------
 ☆数据预处理模块
由于在特征提取的过程中，所采用的C3D模型需要输入视频具有同等的长度（即帧数），且根据对提供视频的分析，为使代码有最佳性能，我们首先对提供视频做预处理，使其长度统一为32帧，以便后续处理。
数据预处理模块的代码在ChaLearn_FLiXT_code/32f_video_generate/目录下，主运行文件为generate_src_video.m。

首先将该文件中的root改为待处理视频的所在目录（如，假设待处理视频为训练视频，其目录为“C:/IsoGD/IsoGD_phase_1/train/”,则root设为该目录即可（目录下为001-180的文件夹）），feature_number设定为视频的个数（训练视频对应35878，测试视频对应6271），writePath改为存放输出视频的文件夹路径（rgb,depth和saliency视频会同时生成并存放在该路径下名为"train_RGB_32frames_whole","train_deep_32frames_whole"和"train_sal_32frames_whole"的三个文件夹下(训练视频)或"test_RGB_32frames_whole","test_deep_32frames_whole"和"test_sal_32frames_whole"的三个文件夹（测试视频））。
*由于生成的32帧视频过大（约30G），暂不上传数据，可通过本代码验证其可行性并生成32帧视频。

------------------------------------------------------------------------------------------------
 ☆特征提取模块
特征提取模块在caffe框架下采用C3D模型实现，主要提取输入视频的特征向量。有关C3D模型及caffe的安装可参照http://www.cs.dartmouth.edu/~dutran/c3d/和http://caffe.berkeleyvision.org/installation.html。

特征提取模块的代码在ChaLearn_FLiXT_code/C3D-master/目录下，首先需要根据目标计算机的情况修改Makefile.config.example,并将符合本计算机情况的配置保存为Makefile.config。然后对模型进行编译，在/C3D-master/目录下打开终端，键入make完成编译。
这一部分主要分为模型训练和特征提取两个部分。训练模型前需要确保所有预处理的32帧视频放在ChaLearn_FLiXT_code/C3D-master/data/目录下，按照数据预处理模块得到的文件夹("train_RGB_32frames_whole","train_deep_32frames_whole"和"train_sal_32frames_whole"的三个文件夹(训练视频)以及"test_RGB_32frames_whole","test_deep_32frames_whole"和"test_sal_32frames_whole"的三个文件夹（测试视频）)可直接复制至此处（这六个文件夹下即为编号为001-180(或001-032)子文件夹）。
　　1、训练C3D模型时，将当前目录切换为C3D-master/examples/c3d_finetuning/，并分别执行：
　　sh IsoGD_deep_finetuning.sh 
　　sh IsoGD_RGB_finetuning.sh 
　　sh IsoGD_sal_finetuning.sh 
用depth、RGB和saliency视频训练模型。
　　上述命令执行完后，会在C3D-master/examples/c3d_finetuning/目录下生成下述三个模型文件
　　c3d_Deep_32f_finetune_no_meanfile_1st_iter_100000
　　c3d_RGB_32f_finetune_no_meanfile_1st_iter_100000
　　c3d_sal_32f_finetune_no_meanfile_1st_iter_100000
（上述文件可在http://pan.baidu.com/s/1qY3YltU处下载得到，下载后请存放在上述目录内)。
* 有关模型的参数设置，如batch-size,请根据测试计算机的具体情况，结合http://www.cs.dartmouth.edu/~dutran/c3d/上的C3D模型userguide进行修改，以避免内存溢出等错误。
　　2、提取视频特征时，将当前目录切换至C3D-master/examples/c3d_feature_extraction/目录下，同时确保在C3D-master/examples/c3d_finetuning/目录下存在上述三个模型文件，并分别执行：
    sh c3d_IsoGD_deep_feature_extraction.sh
    sh c3d_IsoGD_deep_test_feature_extraction.sh
    sh c3d_IsoGD_RGB_feature_extraction.sh
    sh c3d_IsoGD_RGB_test_feature_extraction.sh
    sh c3d_IsoGD_sal_feature_extraction.sh
    sh c3d_IsoGD_sal_test_feature_extraction.sh
　　执行上述命令，在完成特征提取的过程后，会在ChaLearn_FLiXT_code/C3D-master/data/目录下生成32f_deep_train_fc6_100000、32f_RGB_train_fc6_100000、32f_sal_train_fc6_100000、32f_deep_test_fc6_100000、32f_RGB_test_fc6_100000、32f_sal_test_fc6_100000六个目录，分别存放用于训练的depth、RGB、saliency和用于测试的depth、RGB、saliency的fc6特征文件。
------------------------------------------------------------------------------------------------
 ☆分类模块
分类模块利用在上述步骤中获取的特征进行手势识别和分类。该模块通过SVM进行分类。由于SVM实现的是二分类，因此这里使用249个二分类器的组合达到多分类的目的。
分类模块的代码在ChaLearn_FLiXT_code/svm classification/目录下。

1.需要利用该目录下的get_fc6.m生成matlab分类所需的mat格式的特征（即将特征提取模块获取的.fc6特征转化为mat文件）。在使用时，首先将fc6_file_root设置为.fc6文件所在的目录（由特征提取模块生成的fc6特征文件请复制到该目录下，另外，实验所用到的rgb,depth及saliency的训练和测试fc6文件可在http://pan.baidu.com/s/1hr6ahow上下载，将其解压后直接放在./fc6/目录下（请勿添加任何文件夹）并将fc6_file_root按上述方法改为对应目录即可（如./fc6/32f_deep_train_fc6_100000/））。
2.修改变量feature_size的值。根据提取的特征是训练样本还是测试样本的不同，该值可设为35878或6271（训练样本或测试样本的个数）
3.修改feature_type的值。feature_type的可选值为'rgb','deep'和‘sal’,分别对应于输入fc6文件为rgb、depth和saliency特征的情况。
4.执行完成后，会在目录/features/下生成命名格式为“特征类型_32_样本类型_fet_fc6.mat”的文件（如rgb的训练样本对应"rgb_32_train_fet_fc6.mat"，该mat中存放同名的单一变量，即对应特征），该特征即为svm分类器所需特征。
5. libsvm的安装
如上所述，我们所使用的SVM分类器是基于Chih-Jen Lin开发的libsvm，具体信息参考https://www.csie.ntu.edu.tw/~cjlin/libsvm/，这里给出我们的安装方法：
（1）将matlab当前路径改为libsvm中的matlab文件夹的路径，即%libsvmpath%/libsvm-3.17/matlab/ (%libsvmpath%为libsvm存放的路径)
（2）在matlab的command window键入如下命令： mex -setup,以设置编译器编译生成对应的mex文件。首先会提示是否让mex查找编译器所在位置（Would you like mex to locate installed compilers），键入y确认；随后会要求选择目标计算机中C++的编译器（本机为Microsoft Visual C++ 2010 in f:/Program Files (x86)/Microsoft Visual Studio 10.0 ）；选择完成后会看到提示要求确认编译器，确认无误后键入y确认即可（Matlab 2011b及以上支持Visual Studio作为C++编译器，请注意对应matlab及VS的版本）。
（3）在matlab的command window键入make,以运行当前目录下的make.m。待生成“libsvmread.mexw64”、“libsvmwrite.mexw64”、“svmpredict.mexw64”和“svmtrain.mexw64”四个文件即可。
（4）点击matlab的 Set Path(matlab R2012b在上方菜单栏ENVIRONMENT中)，点选Add with Subfolders,选择libsvm-3.17文件夹并确定，添加完成后点击保存，并关闭对话框，即完成libsvm的安装。
6.运行SVM的主文件为run_svm.m。首先需要载入分类所需的训练特征和测试特征（若第四步正确执行，相关特征已正确保存在对应目录下，无需修改。对应特征的mat文件可在http://pan.baidu.com/s/1miCnOwS下载，直接放在/features/目录，即与第四步要求的目录相同即可，训练标签已放置在/features/目录下）。该步骤会生成test样本预测标签的mat文件，直接保存在预测文件生成模块对应路径下。

------------------------------------------------------------------------------------------------
☆预测文件生成模块
预测文件生成模块是根据分类模块得到的标签mat文件，对应竞赛提供的无标签test_list.txt，生成符合提交要求的test_prediction.txt文件的模块。
预测文件生成模块的代码在ChaLearn_FLiXT_code/get_predict_file/目录下。

本模块只需运行 get_label_with_mat.m即可。首先将f_unlabel_txt改为test_list.txt的所在目录（已在当前目录下放置该txt文件），随后载入test标签的mat文件(如分类模块执行正确，在./mat/目录下已经生成该mat文件)。然后设定f_label_txt为输出的test_prediction.txt所在路径（默认即在当前目录下生成）。运行完毕后即可得到符合提交要求的test_prediction.txt。

全部操作完成。
