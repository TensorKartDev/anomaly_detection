function [data, timeSeconds] = parseDateTimeColumn(data)
%PARSEDATETIMECOLUMN Ensures DateTime column is parsed correctly

    if ~ismember('DateTime', data.Properties.VariableNames)
        error('DateTime column not found in data.');
    end

    try
        data.DateTime = datetime(data.DateTime, ...
            'InputFormat', 'yyyy/MM/dd HH:mm:ss', ...
            'Locale', 'en_US');
        rawTime = data.DateTime;
        dt = datetime(rawTime);  % extra safety
        timeSeconds = seconds(dt - dt(1));

    catch ME1
        fprintf('First datetime() parsing failed: %s\n', ME1.message);
        try
            timeSeconds = data.DateTime - data.DateTime(1);
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