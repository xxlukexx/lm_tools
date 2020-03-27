classdef uitableexplorer < handle
    
    properties (SetAccess = private)
        Table 
    end
    
    properties (Access = private)
        prFilterTable 
    end
    
    methods
        
        function obj = tableexplorer(tab)
            
            if nargin == 0 || ~istable(tab)
                error('Must pass a Matlab table to instantiate this class.')
            end
            obj.Table = tab;
            
            % init filtertable
            
            % init event listeners
            
            
        end
        
    end
    
end
                