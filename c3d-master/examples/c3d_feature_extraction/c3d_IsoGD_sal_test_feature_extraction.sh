mkdir ../../data/32f_sal_test_fc6_100000

GLOG_logtosterr=1 ../../build/tools/extract_image_features.bin prototxt/c3d_IsoGD_sal_finetuning_test.prototxt ../c3d_finetuning/c3d_sal_32f_finetune_no_meanfile_1st_iter_100000 0 1 6271 prototxt/test_sal_32frames_whole_output.txt fc6
