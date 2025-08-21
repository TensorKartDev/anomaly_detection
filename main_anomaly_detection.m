%% Main Script: Weld Data Processing
clear; clc;

%% Step 1: Load data
filePath = 'Welddata_plasticWelding_2021_11_24/WeldResultTable_20211124_162110.csv';
data = loadWeldData(filePath);

%% Step 2: Parse DateTime column
[data, timeSeconds] = parseDateTimeColumn(data);

%% Step 3: Select relevant features
selectedFeatures = selectRelevantFeatures(data);

%% [OPTIONAL] Step 4: Add your next processing steps (normalization, clustering, etc.)
% Example:
% normData = normalizeWeldData(selectedFeatures);