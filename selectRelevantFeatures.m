function selectedFeatures = selectRelevantFeatures(data, selectedCols)
%SELECTRELEVANTFEATURES Extracts relevant columns & removes rows with missing values

    selectedCols = {
        'DateTime','CycleCounter','MaxWeldForce','WeldAbsolute', ...
        'TriggerDistance','WeldTime','WeldPeakPower','CycleTime'};

    % Check for missing columns
    missing = setdiff(selectedCols, data.Properties.VariableNames);
    if ~isempty(missing)
        warning('Missing columns: %s\n', strjoin(missing, ', '));
    end

    availableCols = intersect(selectedCols, data.Properties.VariableNames);
    selectedFeatures = data(:, availableCols);

    % Drop rows with missing values
    validIdx = ~any(ismissing(selectedFeatures), 2);
    selectedFeatures = selectedFeatures(validIdx, :);

    % Validate DateTime
    if ~ismember('DateTime', selectedFeatures.Properties.VariableNames)
        error('DateTime column missing after selection.');
    end
    if ~isdatetime(selectedFeatures.DateTime)
        error('DateTime must be in datetime format.');
    end
end