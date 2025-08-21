function data = loadWeldData(filePath)
%LOADWELDDATA Load CSV data with original column names preserved
    if ~isfile(filePath)
        error('File not found: %s', filePath);
    end
    data = readtable(filePath, 'VariableNamingRule', 'preserve');

    %% Try to convert DateTime co\lumn, or fall back to row index if all else fails
    
    data.DateTime = datetime(data.DateTime, ...
        'InputFormat', 'yyyy/MM/dd HH:mm:ss', ...
        'Locale', 'en_US'); 
    rawTime = data.DateTime
    try
        % Try parsing as datetime
        dt = datetime(rawTime);
        timeSeconds = seconds(dt - dt(1));  % time since first
        
    catch ME1
        fprintf('First datetime() parsing failed: %s\n', ME1.message);
        try
            % Try as numeric (e.g., Excel serial date)
            timeSeconds = rawTime - rawTime(1);
            if ~isnumeric(timeSeconds)
                error('Converted time is not numeric.');
            end
        catch ME2
            fprintf('Second numeric conversion failed: %s\n', ME2.message);
            warning('Falling back to row index as time axis.\n');
            timeSeconds = (1:height(data))';  % fallback
        end
    end

end