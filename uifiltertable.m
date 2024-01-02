classdef uifiltertable < handle
    
    properties (SetAccess = private)
        SelectedColumn
        SelectedRow
    end
    
    properties (Dependent, SetAccess = private)
        Table 
    end
    
    properties (Access = private)
        prTab
        prFilters
        prColumnDataType
        uiParent
        uiPnlFilter
        uiLblSelectedColumn
        uiCmbFilterValues
        uiTxtFilterExp
        uiTab
    end
    
    properties (Dependent, Access = private)
        prPos 
    end
    
    events
        SelectionChanged
        FilterChanged
    end

    methods
        
        function obj = uifiltertable(tab, parent)
            
            if ~exist('tab', 'var') || ~istable(tab) || isempty(tab)
                error('Must pass a Matlab table to instantiate this class.')
            end
            obj.Table = tab;
            
            if ~exist('parent', 'var')
                parent = uifigure('Name', 'Filter Table');
            end
            obj.uiParent = parent;
            
            obj.UIDraw
            
        end
        
        function UIDraw(obj)
            
            pos = obj.prPos;
            
            obj.uiPnlFilter = uipanel('Parent', obj.uiParent,...
                'Position', obj.prPos.uiPnlFilter);
            
                obj.uiLblSelectedColumn = uilabel('Parent', obj.uiPnlFilter,...
                    'Text', 'No selection',...
                    'Position', obj.prPos.lblSelectedColumn);
                
                obj.uiCmbFilterValues = uidropdown('Parent', obj.uiPnlFilter,...
                    'Position', obj.prPos.cmbFilterValues);
                
                obj.uiTxtFilterExp = uieditfield('Parent', obj.uiPnlFilter,...
                    'Position', obj.prPos.txtFilterExp);
            
            obj.uiTab = uitable('Parent', obj.uiParent,...
                'Position', obj.prPos.uiTab,...
                'Data', obj.Table,...
                'ColumnSortable', true(1, size(obj.Table, 2)),...
                'CellSelectionCallback', @obj.uiTab_CellSelection);
            
        end
        
        function UIUpdateSelectedColumnFilters(obj)
            
            % update label
            obj.uiLblSelectedColumn.Text =...
                obj.Table.Properties.VariableNames{obj.SelectedColumn};
            
            % get unique values
            val_u = unique(obj.Table{:, obj.SelectedRow});
            obj.uiCmbFilterValues.Items = val_u;
            
        end
        
        function CreateFilters(obj)
            
            if isempty(obj.Table)
                obj.prFilters = [];
                return
            end
            
            numCols = size(obj.Table, 2);
            obj.prFilters = cell(1, numCols);
            
        end
        
        % UI callbacks
        function uiTab_CellSelection(obj, ~, event)
           
            obj.SelectedColumn = event.Indices(2);
            obj.SelectedRow = event.Indices(1);
            obj.UIUpdateSelectedColumnFilters
            
        end
        
        % get/set
        function val = get.Table(obj)
            
            % apply filters
            
            val = obj.prTab;
        end
        
        function val = get.prPos(obj)
            
            w = obj.uiParent.Position(3);
            h = obj.uiParent.Position(4);
            
            % filter panel is top 60 px
            h_filter = 60;
            val.uiPnlFilter = [0, h - h_filter, w, h_filter];
            
            % selected column label
            w_lblSel = 200;
            val.lblSelectedColumn = [0, 0, w_lblSel, h_filter];
            
            % filter values
            w_filtVals = 400;
            val.cmbFilterValues = [w_lblSel, 0, w_filtVals, h_filter];
            
            % free text filter
            val.txtFilterExp = [w_lblSel + w_filtVals, 0, w_filtVals, h_filter];
            
            % table panel is rest of window
            val.uiTab = [0, 0, w, h - h_filter];
            
            
            
        end
        
        function set.Table(obj, val)
            
            obj.CreateFilters
            obj.prTab = val;
            obj.uiTab.Data = val;
            obj.CreateFilters
            
        end
        
    end
    
end