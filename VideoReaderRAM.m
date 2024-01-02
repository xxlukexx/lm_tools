classdef VideoReaderRAM < VideoReader
    
    properties %(Access = private)
        prCache
        prTimeLookup
        prCacheIdx
        prNumFrames = 1000;
    end 
    
    methods
        
        function obj = VideoReaderRAM(varargin)
            obj = obj@VideoReader(varargin{:});
            obj.prCache = cell(obj.prNumFrames, 1);
            obj.prCacheIdx = 1;
            obj.prTimeLookup = nan(obj.prNumFrames, 1);
        end
        
        function fr = readFrame(obj, varargin)
            
            % check if current time is cached
            idx = find(obj.prTimeLookup(:, 1) == obj.CurrentTime, 1);
            if isempty(idx)
                tic
                fr = readFrame@VideoReader(obj, varargin{:});
                obj.prCache{obj.prCacheIdx} = fr;
                obj.prTimeLookup(obj.prCacheIdx, 1) = obj.CurrentTime;
                fprintf('Cache MISS for time %.2f -- %.2fms\n', obj.CurrentTime, toc * 1000);
            else
                fprintf('Cache HIT for time %.2f -- %.2fms\n', obj.CurrentTime, toc * 1000);
                fr = obj.prCache(idx);
            end
            
        end
        
    end
    
end