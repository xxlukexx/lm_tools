function map = cmap_sig(n)

    if nargin < 1
       f = get(groot,'CurrentFigure');
       if isempty(f)
          m = size(get(groot,'DefaultFigureColormap'),1);
       else
          m = size(f.Colormap,1);
       end
    end

    values = [...
        0.5 0.9 0.5
        1.0 1.0 1.0];

    P = size(values,1);
    map = interp1(1:size(values,1), values, linspace(1,P,m), 'linear');

end

