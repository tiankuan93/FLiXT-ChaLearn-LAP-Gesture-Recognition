mkdir ../../data/32f_sal_train_fc6_100000

GLOG_logtosterr=1 ../../build/tools/extract_image_features.bin prototxt/c3d_IsoGD_sal_finetuning_train.prototxt ../c3d_finetuning/c3d_sal_32f_finetune_no_meanfile_1st_iter_100000 0 1 35878 prototxt/train_sal_32frames_whole_output.txt fc6
