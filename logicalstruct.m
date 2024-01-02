classdef logicalstruct
% emulates a matlab struct, but returns false if a field 


    properties (Access = private)
        data = struct
    end
    
    methods
        
        function obj = logicalstruct(varargin)
            % create lstruct from either struct or fieldname/value string
            % pairs
            if numel(varargin) == 1 && isstruct(varargin{1})
                obj.data = varargin{1};
            elseif iscellstr(varargin)
                obj.data = struct(varargin{:});
            elseif ~isempty(varargin)
                error('Initialise this class with either a struct or fieldname/value string pairs.')
            end
        end
        
        function obj = subsasgn(obj, s, varargin)
            
            allTypesAreDot = all(cellfun(@(x) strcmpi(x, '.'), {s.type}));
            if ~allTypesAreDot
                % if the input subs are not one.two.three (i.e. all
                % separated by dots), then pass to builtin
                try
                varargout = {builtin('subsref', obj.data, s)};
                catch ERR
                    disp('arse')
                end
%                 obj.data = builtin('subsasgn', obj.data.(s(1).subs), s(2:end), varargin{:});
                return
            end
            
            % build a command to assign varargin to the internal struct
            subsc = {s(1:end).subs};
            subStr = 'obj.data';
            for i = 1:length(s)
                subStr = sprintf('%s.%s', subStr, subsc{i});
            end
            subStr = [subStr, '=varargin{:};'];
            eval(subStr);
        end

        function varargout = subsref(obj, s)
            
            allTypesAreDot = all(cellfun(@(x) strcmpi(x, '.'), {s.type}));
            if ~allTypesAreDot
                % if the input subs are not one.two.three (i.e. all
                % separated by dots), then pass to builtin
                varargout = {builtin('subsref', obj.data, s)};
                return
            end            
            
            subsc = {s(1:end).subs};
            subStr = 'obj.data';
            for i = 1:length(s)
                subStr = sprintf('%s.%s', subStr, subsc{i});
            end
            try
                varargout = {eval(subStr)};
                return
            catch ERR
                switch ERR.identifier
                    case 'MATLAB:nonExistentField'
                        varargout = {false};
                    otherwise
                        rethrow(ERR)
                end
            end

        end
        
        function disp(obj)
            if isempty(obj.data)
                fprintf('<strong>  logicalstruct</strong> with no fields.\n\n')
            else
                fprintf('<strong>  logicalstruct</strong> with fields:\n\n')
            end
            builtin('disp', obj.data)
        end
        
        function obj = rmfield(obj, varargin)
            obj.data = rmfield(obj.data, varargin{:});
        end
        
        function val = fieldnames(obj)
            val = builtin('fieldnames', obj.data);
        end
        
        function val = isfield(obj, varargin)
            val = builtin('isfield', obj.data, varargin{:});
        end      
        
        function val = getfield(obj, varargin)
            val = getfield(obj.data, varargin{:});
        end           
        
        function setfield(obj, varargin)
            obj.data = setfield(obj.data, varargin{:});
        end   
        
        function val = orderfields(obj, varargin)
            obj.data = orderfields(obj.data, varargin{:});
            val = obj.data;
        end   
        
        function val = isstruct(~, varargin)
            val = true;
        end
        
        function val = struct(obj)
            val = obj.data;
        end
        
        function val = struct2cell(obj)
            val = struct2cell(struct(obj));
        end
        
        function val = struct2table(obj)
            val = struct2table(struct(obj));
        end
        
        function properties(obj)
            builtin('properties', obj.data)
        end           
                
    end
    
end
