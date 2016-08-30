function [samplingFrames] = sampling(numOfFrames, benchmark)
    samplingFrames = zeros(1,benchmark);
    ratio = numOfFrames/benchmark;
    if ratio > 1 % ֱ�Ӱ��ղ�����ȡ��
        for i=1:benchmark
            samplingFrames(i) = min(round(i*ratio),numOfFrames);
        end
    else if ratio < 1 
       %��֡��Ϊ���ӣ����ȼ�����֡��������ÿ֡��Ҫ��������٣�������������������������Ҫ����������ɺ��Ŀ��Ҫ��32f���Ĳ��
       %Ȼ�����������Ӧ������֡�ţ�����Ӧ֡����Ҫ������һ��
       %����ʱ������ʵ��Ƶ����ԭʼinput����ÿһ֡���бȶԣ�����֡��ѡ��Ϊ�������֡��������32֡λ�������Ӧ�����ĸ�֡
       %Ȼ����Ӷ�Ӧ��֡��������֡
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
        