������FLiXT
�鳤�������
��Ա����� ��ӨӨ ��� ����
================================================================================================
��Ҫ˵��
���ǵĴ���ɷ�Ϊ�ĸ�ģ�飺����Ԥ����ģ�飬������ȡģ�飬����ģ���Ԥ���ļ�����ģ�顣����������ȡ���������ѧϰ������caffeƽ̨�£�ͨ��C3Dģ�ͣ�һ����ά��������磩ʵ�ֵģ�����ģ�����ǻ���Chih-Jen Lin������libsvmʵ�ֵġ���������ȡģ�飬����ģ�������matlab����ʵ�֡�
================================================================================================
����Ŀ¼��
ChaLearn_FLiXT_code
 |
 |������32f_video_generate (����Ԥ��������ָ��֡������Ƶ)
 |         |
 |         |��generate_src_video.m ����Ҫ�����ļ���
 |         |��get_saliency.m   (��ȡsaliency��Ƶ)
 |         |��saliency.m   (���õ�saliency��ȡ����)
 |         |��sampling.m   (ȷ������Ƶ��)
 |
 |������C3D-master   (������ȡ������C3Dģ��ʵ��ѵ����������ȡ)
 |         |
 |         |������data  ��������ݣ���������õ���32֡���ݣ����ɵ�fc6�����ļ�Ҳ��洢�����
 |         |������examples  ��ѵ��ģ�ͺ�������ȡ���룩
 |         |         |������c3d_finetuning  ��ģ�͵�ѵ����
 |         |         |       |��IsoGD_deep_finetuning.sh (��depth���ݽ���fine tune)
 |         |         |       |��IsoGD_RGB_finetuning.sh  (��rgb���ݽ���fine tune)
 |         |         |       |��IsoGD_sal_finetuning.sh (��saliency���ݽ���fine tune)
 |         |         |       |...
 |         |         |
 |	   |         |������c3d_feature_extraction (������ȡ)
 |         |                 |��c3d_IsoGD_deep_feature_extraction.sh (��ȡdepthѵ����������)
 |         |                 |��c3d_IsoGD_deep_test_feature_extraction.sh(��ȡdepth������������)
 |         |                 |��c3d_IsoGD_RGB_feature_extraction.sh (��ȡrgbѵ����������)
 |         |                 |��c3d_IsoGD_RGB_test_feature_extraction.sh(��ȡrgb������������)
 |         |                 |��c3d_IsoGD_sal_feature_extraction.sh (��ȡsaliencyѵ����������)
 |         |                 |��c3d_IsoGD_sal_test_feature_extraction.sh(��saliency������������)
 |         |                 |...
 |         |��Makefile.config.example��Caffe �������������ļ����ɸ���Ŀ�������������ò�����Makefile.config�� 
 |         |...
 | 
 |������svm classification  ��SVM���࣬�谲װlibsvm��
 |         |
 |         |��get_fc6.m   (��ͨ��C3Dģ����ȡ������ת��Ϊmat��ʽ)
 |         |��run_svm.m   (SVM������Ҫ���е��ļ�)
 |         |��SVMClassification.m   (SVM���ຯ��)
 |         |��fc6   (���C3Dģ����ȡ������fc6�ļ���Ŀ¼��fc6�ļ�����C3D���ɻ�ֱ����http://pan.baidu.com/s/1hr6ahow����)
 |         |��features   (���ת��������mat�ļ�����Щ�ļ�����get_fc6.m���ɻ�ֱ��������http://pan.baidu.com/s/1miCnOwS)
 |         |��libsvm-3.17  (libsvm�����)
 |        
 |������get_predict_file  (��ȡ��������Ҫ���test_prediction�ļ�)
 |         |��get_label_with_mat.m  (ͨ��test_predict_label.mat����test_prediction.txt)
 |         |��test_list.txt  �������ṩ��δ��ǩlist��
 |         |��mat  �����SVM����õ�test�ı�ǩmat�ļ���
 |
 |������ʹ��˵��.txt
 |������readme.txt

================================================================================================
���Ի���
Ӳ��
  CPU��Intel Core i7-6700 CPU @ 3.40GHz ��8
  �ڴ棺16G
  GPU��Nvidia Geforce GTX TITAN X
�����
  Windows 7 64-bit
  Linux Ubuntu 14.04 LTS (���caffeƽ̨)
  Matlab R2012b������
================================================================================================

�������в���
���½���ģ�����˵��ÿ��ģ�����;����ش�������в��衣
------------------------------------------------------------------------------------------------
 ������Ԥ����ģ��
������������ȡ�Ĺ����У������õ�C3Dģ����Ҫ������Ƶ����ͬ�ȵĳ��ȣ���֡�������Ҹ��ݶ��ṩ��Ƶ�ķ�����Ϊʹ������������ܣ��������ȶ��ṩ��Ƶ��Ԥ����ʹ�䳤��ͳһΪ32֡���Ա��������
����Ԥ����ģ��Ĵ�����ChaLearn_FLiXT_code/32f_video_generate/Ŀ¼�£��������ļ�Ϊgenerate_src_video.m��

���Ƚ����ļ��е�root��Ϊ��������Ƶ������Ŀ¼���磬�����������ƵΪѵ����Ƶ����Ŀ¼Ϊ��C:/IsoGD/IsoGD_phase_1/train/��,��root��Ϊ��Ŀ¼���ɣ�Ŀ¼��Ϊ001-180���ļ��У�����feature_number�趨Ϊ��Ƶ�ĸ�����ѵ����Ƶ��Ӧ35878��������Ƶ��Ӧ6271����writePath��Ϊ��������Ƶ���ļ���·����rgb,depth��saliency��Ƶ��ͬʱ���ɲ�����ڸ�·������Ϊ"train_RGB_32frames_whole","train_deep_32frames_whole"��"train_sal_32frames_whole"�������ļ�����(ѵ����Ƶ)��"test_RGB_32frames_whole","test_deep_32frames_whole"��"test_sal_32frames_whole"�������ļ��У�������Ƶ������
*�������ɵ�32֡��Ƶ����Լ30G�����ݲ��ϴ����ݣ���ͨ����������֤������Բ�����32֡��Ƶ��

------------------------------------------------------------------------------------------------
 ��������ȡģ��
������ȡģ����caffe����²���C3Dģ��ʵ�֣���Ҫ��ȡ������Ƶ�������������й�C3Dģ�ͼ�caffe�İ�װ�ɲ���http://www.cs.dartmouth.edu/~dutran/c3d/��http://caffe.berkeleyvision.org/installation.html��

������ȡģ��Ĵ�����ChaLearn_FLiXT_code/C3D-master/Ŀ¼�£�������Ҫ����Ŀ������������޸�Makefile.config.example,�������ϱ��������������ñ���ΪMakefile.config��Ȼ���ģ�ͽ��б��룬��/C3D-master/Ŀ¼�´��նˣ�����make��ɱ��롣
��һ������Ҫ��Ϊģ��ѵ����������ȡ�������֡�ѵ��ģ��ǰ��Ҫȷ������Ԥ�����32֡��Ƶ����ChaLearn_FLiXT_code/C3D-master/data/Ŀ¼�£���������Ԥ����ģ��õ����ļ���("train_RGB_32frames_whole","train_deep_32frames_whole"��"train_sal_32frames_whole"�������ļ���(ѵ����Ƶ)�Լ�"test_RGB_32frames_whole","test_deep_32frames_whole"��"test_sal_32frames_whole"�������ļ��У�������Ƶ��)��ֱ�Ӹ������˴����������ļ����¼�Ϊ���Ϊ001-180(��001-032)���ļ��У���
����1��ѵ��C3Dģ��ʱ������ǰĿ¼�л�ΪC3D-master/examples/c3d_finetuning/�����ֱ�ִ�У�
����sh IsoGD_deep_finetuning.sh 
����sh IsoGD_RGB_finetuning.sh 
����sh IsoGD_sal_finetuning.sh 
��depth��RGB��saliency��Ƶѵ��ģ�͡�
������������ִ����󣬻���C3D-master/examples/c3d_finetuning/Ŀ¼��������������ģ���ļ�
����c3d_Deep_32f_finetune_no_meanfile_1st_iter_100000
����c3d_RGB_32f_finetune_no_meanfile_1st_iter_100000
����c3d_sal_32f_finetune_no_meanfile_1st_iter_100000
�������ļ�����http://pan.baidu.com/s/1qY3YltU�����صõ������غ�����������Ŀ¼��)��
* �й�ģ�͵Ĳ������ã���batch-size,����ݲ��Լ�����ľ�����������http://www.cs.dartmouth.edu/~dutran/c3d/�ϵ�C3Dģ��userguide�����޸ģ��Ա����ڴ�����ȴ���
����2����ȡ��Ƶ����ʱ������ǰĿ¼�л���C3D-master/examples/c3d_feature_extraction/Ŀ¼�£�ͬʱȷ����C3D-master/examples/c3d_finetuning/Ŀ¼�´�����������ģ���ļ������ֱ�ִ�У�
    sh c3d_IsoGD_deep_feature_extraction.sh
    sh c3d_IsoGD_deep_test_feature_extraction.sh
    sh c3d_IsoGD_RGB_feature_extraction.sh
    sh c3d_IsoGD_RGB_test_feature_extraction.sh
    sh c3d_IsoGD_sal_feature_extraction.sh
    sh c3d_IsoGD_sal_test_feature_extraction.sh
����ִ��������������������ȡ�Ĺ��̺󣬻���ChaLearn_FLiXT_code/C3D-master/data/Ŀ¼������32f_deep_train_fc6_100000��32f_RGB_train_fc6_100000��32f_sal_train_fc6_100000��32f_deep_test_fc6_100000��32f_RGB_test_fc6_100000��32f_sal_test_fc6_100000����Ŀ¼���ֱ�������ѵ����depth��RGB��saliency�����ڲ��Ե�depth��RGB��saliency��fc6�����ļ���
------------------------------------------------------------------------------------------------
 �����ģ��
����ģ�����������������л�ȡ��������������ʶ��ͷ��ࡣ��ģ��ͨ��SVM���з��ࡣ����SVMʵ�ֵ��Ƕ����࣬�������ʹ��249��������������ϴﵽ������Ŀ�ġ�
����ģ��Ĵ�����ChaLearn_FLiXT_code/svm classification/Ŀ¼�¡�

1.��Ҫ���ø�Ŀ¼�µ�get_fc6.m����matlab���������mat��ʽ������������������ȡģ���ȡ��.fc6����ת��Ϊmat�ļ�������ʹ��ʱ�����Ƚ�fc6_file_root����Ϊ.fc6�ļ����ڵ�Ŀ¼����������ȡģ�����ɵ�fc6�����ļ��븴�Ƶ���Ŀ¼�£����⣬ʵ�����õ���rgb,depth��saliency��ѵ���Ͳ���fc6�ļ�����http://pan.baidu.com/s/1hr6ahow�����أ������ѹ��ֱ�ӷ���./fc6/Ŀ¼�£���������κ��ļ��У�����fc6_file_root������������Ϊ��ӦĿ¼���ɣ���./fc6/32f_deep_train_fc6_100000/������
2.�޸ı���feature_size��ֵ��������ȡ��������ѵ���������ǲ��������Ĳ�ͬ����ֵ����Ϊ35878��6271��ѵ����������������ĸ�����
3.�޸�feature_type��ֵ��feature_type�Ŀ�ѡֵΪ'rgb','deep'�͡�sal��,�ֱ��Ӧ������fc6�ļ�Ϊrgb��depth��saliency�����������
4.ִ����ɺ󣬻���Ŀ¼/features/������������ʽΪ����������_32_��������_fet_fc6.mat�����ļ�����rgb��ѵ��������Ӧ"rgb_32_train_fet_fc6.mat"����mat�д��ͬ���ĵ�һ����������Ӧ����������������Ϊsvm����������������
5. libsvm�İ�װ
����������������ʹ�õ�SVM�������ǻ���Chih-Jen Lin������libsvm��������Ϣ�ο�https://www.csie.ntu.edu.tw/~cjlin/libsvm/������������ǵİ�װ������
��1����matlab��ǰ·����Ϊlibsvm�е�matlab�ļ��е�·������%libsvmpath%/libsvm-3.17/matlab/ (%libsvmpath%Ϊlibsvm��ŵ�·��)
��2����matlab��command window����������� mex -setup,�����ñ������������ɶ�Ӧ��mex�ļ������Ȼ���ʾ�Ƿ���mex���ұ���������λ�ã�Would you like mex to locate installed compilers��������yȷ�ϣ�����Ҫ��ѡ��Ŀ��������C++�ı�����������ΪMicrosoft Visual C++ 2010 in f:/Program Files (x86)/Microsoft Visual Studio 10.0 ����ѡ����ɺ�ῴ����ʾҪ��ȷ�ϱ�������ȷ����������yȷ�ϼ��ɣ�Matlab 2011b������֧��Visual Studio��ΪC++����������ע���Ӧmatlab��VS�İ汾����
��3����matlab��command window����make,�����е�ǰĿ¼�µ�make.m�������ɡ�libsvmread.mexw64������libsvmwrite.mexw64������svmpredict.mexw64���͡�svmtrain.mexw64���ĸ��ļ����ɡ�
��4�����matlab�� Set Path(matlab R2012b���Ϸ��˵���ENVIRONMENT��)����ѡAdd with Subfolders,ѡ��libsvm-3.17�ļ��в�ȷ���������ɺ������棬���رնԻ��򣬼����libsvm�İ�װ��
6.����SVM�����ļ�Ϊrun_svm.m��������Ҫ������������ѵ�������Ͳ��������������Ĳ���ȷִ�У������������ȷ�����ڶ�ӦĿ¼�£������޸ġ���Ӧ������mat�ļ�����http://pan.baidu.com/s/1miCnOwS���أ�ֱ�ӷ���/features/Ŀ¼��������Ĳ�Ҫ���Ŀ¼��ͬ���ɣ�ѵ����ǩ�ѷ�����/features/Ŀ¼�£����ò��������test����Ԥ���ǩ��mat�ļ���ֱ�ӱ�����Ԥ���ļ�����ģ���Ӧ·���¡�

------------------------------------------------------------------------------------------------
��Ԥ���ļ�����ģ��
Ԥ���ļ�����ģ���Ǹ��ݷ���ģ��õ��ı�ǩmat�ļ�����Ӧ�����ṩ���ޱ�ǩtest_list.txt�����ɷ����ύҪ���test_prediction.txt�ļ���ģ�顣
Ԥ���ļ�����ģ��Ĵ�����ChaLearn_FLiXT_code/get_predict_file/Ŀ¼�¡�

��ģ��ֻ������ get_label_with_mat.m���ɡ����Ƚ�f_unlabel_txt��Ϊtest_list.txt������Ŀ¼�����ڵ�ǰĿ¼�·��ø�txt�ļ������������test��ǩ��mat�ļ�(�����ģ��ִ����ȷ����./mat/Ŀ¼���Ѿ����ɸ�mat�ļ�)��Ȼ���趨f_label_txtΪ�����test_prediction.txt����·����Ĭ�ϼ��ڵ�ǰĿ¼�����ɣ���������Ϻ󼴿ɵõ������ύҪ���test_prediction.txt��

ȫ��������ɡ�
