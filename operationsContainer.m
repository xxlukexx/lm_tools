classdef operationsContainer < handle
    
    properties
        Warnings
    end
    
    properties (Access = private)
        s
    end
    
    methods
        
        function obj = operationsContainer
            
            % init private internal storage
            obj.s = struct;
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
        end
        
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
            else
                varargout = {builtin('subsref', obj.s, s)};
            end
        end        
        
    end
    
end