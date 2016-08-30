function [samplingFrames] = sampling(numOfFrames, benchmark)
    samplingFrames = zeros(1,benchmark);
    ratio = numOfFrames/benchmark;
    if ratio > 1 % 直接按照采样率取整
        for i=1:benchmark
            samplingFrames(i) = min(round(i*ratio),numOfFrames);
        end
    else if ratio < 1 
       %扩帧较为复杂，首先计算扩帧倍数，即每帧需要被扩充多少，由于扩充的是整数倍，因此需要计算扩充完成后和目标要求（32f）的差别
       %然后随机生成相应数量的帧号，即对应帧号需要在扩充一次
       %扩充时，对真实视频（即原始input）的每一帧进行比对，若该帧被选定为随机增补帧，则先在32帧位中添加相应数量的该帧
       %然后添加对应扩帧倍数个该帧
        ext_ratio = floor(1/ratio);
        cat= round(1+(numOfFrames-1)*rand(1,benchmark-ext_ratio*numOfFrames));
        
        for i=1:numOfFrames
            pos = find(samplingFrames==0);
            idx = pos(1);
            sz = size(find(cat==i));
            if sz(2)~=0
%                 disp('!eq 0')
                samplingFrames(1,idx:idx+sz(2)-1)=i;
                pos = find(samplingFrames==0);
                idx = pos(1);
            end
            
            samplingFrames(1,idx:idx+ext_ratio-1) = i;
            
            
        end
    end
end
        