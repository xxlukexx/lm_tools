function parsave(filename, data, opt)

    if exist('opt', 'var') && isempty(opt)
        save(filename, 'data', opt)
    else
        save(filename, 'data')
    end
    
end