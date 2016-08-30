% This m-file generates 32-frame videos which is required for the C3D 
% model (extracting features)
% The variable 'root' indicates the root directory of original video provided by the
% challenge (here assuming the train videos are waiting for processing.)
% The variable 'feature_number' indicates the number of sample. In other
% words, when feature_number equals 35878, the train samples are
% processed,whereas 6271 indicates test samples.
% the files are unzipped and locate at 'C:/IsoGD/IsoGD_phase_1/train/')
% The variable 'writePath' indicates the location of generated 32-frame videos. The
% RGB-video, depth-video and saliency-video are genreated in the same time.
% The saliency video is obtained in terms of the code provided by Achanta
% associated with "Frequency-tuned Salient Region Detection" on CVPR '09.
% More information about it can be seen in the saliency.m.

clear
clc


root = 'C:/IsoGD/IsoGD_phase_1/train/';
feature_number = 35878;  % please modify it to 35878 for training data and 6271 for test data

sample_type = '';
if feature_number == 35878
    sample_type = 'train';
else if feature_number == 6271
        sample_type = 'test';
    end
end

writePath = './32frames_video/';

benchmarkNumFrame = 32;

for i=1:180
    i
    folderName = num2str(i);
    for j =1:3-length(folderName)
        folderName = ['0',folderName]; % 
    end
    
    direct = [root,folderName];
    Mfiles = dir([direct,'/M_*.avi']);
    Kfiles = dir([direct,'/K_*.avi']);
    
   for j = 1:length(Mfiles)
       Mobj = VideoReader([root,folderName,'/',Mfiles(j).name]);
       numFrames = Mobj.NumberOfFrames;
       rate = Mobj.FrameRate;
       Mvideo = read(Mobj);
       
       Kobj = VideoReader([root,folderName,'/',Kfiles(j).name]);
       Kvideo = read(Kobj);
       % condition 
       samp = sampling(numFrames,benchmarkNumFrame); % sampling!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
       
       % write
       if ~exist([writePath,sample_type,'_RGB_32frames_whole/',folderName])
           mkdir([writePath,sample_type,'_RGB_32frames_whole/',folderName]);
       end
       
        if ~exist([writePath,sample_type,'_deep_32frames_whole/',folderName])
           mkdir([writePath,sample_type,'_deep_32frames_whole/',folderName]);
        end
       
        if ~exist([writePath,sample_type,'_sal_32frames_whole/',folderName])
           mkdir([writePath,sample_type,'_sal_32frames_whole/',folderName]);
        end
       
       wMObj = VideoWriter([writePath,sample_type,'_RGB_32frames_whole/',folderName,'/',Mfiles(j).name]);
       wKObj = VideoWriter([writePath,sample_type,'_deep_32frames_whole/',folderName,'/',Kfiles(j).name]);
       str = Mfiles(j).name;
       wSObj = VideoWriter([writePath,sample_type,'_sal_32frames_whole/',folderName,'/S',str(2:length(str))]);
       wMObj.FrameRate = rate;
       wKObj.FrameRate = rate;
       wSObj.FrameRate = rate;
       open(wMObj);
       open(wKObj);
       open(wSObj);
       for len = 1:length(samp)
           Mimg = Mvideo(:,:,:,samp(len));
           writeVideo(wMObj,Mimg);
           
           Kimg = Kvideo(:,:,:,samp(len));
           writeVideo(wKObj,Kimg);
           
           Simg = get_saliency(Mimg);
           writeVideo(wSObj,Simg);
       end
       
       close(wMObj);
       close(wKObj);
       close(wSObj);
       
       fclose all;
   end
   

end
