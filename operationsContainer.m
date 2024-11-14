classdef operationsContainer < handle
    
    properties
        Warnings
    end
    
    properties (Access = private)
        s
    end
    
    methods
        
        function obj = operationsContainer(s)
            
            % init private internal storage
            if exist('s', 'var') 
                if ~isstruct(s)
                    error('Must pass a struct or nothing')
                else
                    obj.s = s;
                end
            else
                obj.s = struct;
            end
            obj.Warnings = {};
            
        end
        
        function s = struct(obj)
            
            % return a struct by concatenating the internal struct data
            % with the Warnings field
            s = obj.s;
            for i = 1:length(obj.Warnings)
                s.(sprintf('warning%02d', i)) = obj.Warnings{i};
            end
            
        end
        
        function AddWarning(obj, val)
            obj.Warnings{end + 1} = val;
            warning('%s', val);
        end
        
%         function SetIndex(obj, val)
%             if isfield(obj.s, val)
%                 obj.Index = val;
%             else
%                 error('Index variable does not exist.')
%             end
%         end
        
        function obj = subsasgn(obj, s, varargin)
            if length(s) == 1 && strcmpi(s.type, '.')
                obj.s.(s.subs) = varargin{:};
            else
                obj.s = builtin('subsasgn', obj.s, s, varargin{:});
            end
        end
        
        function varargout = subsref(obj, s)
            % catch AddWarning call
            if length(s) == 2 && strcmpi(s(1).type, '.') &&...
                    strcmpi(s(1).subs, 'AddWarning')
                obj.Warnings{end + 1} = s(2).subs;
                fprintf('[operations warning]:%s\n', s(2).subs{1});
                1 == 1;
            else
                varargout = {builtin('subsref', obj.s, s)};
            end
        end        
        
    end
    
end