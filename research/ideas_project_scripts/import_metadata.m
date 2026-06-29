clc
clear

%% Import data from text file: Metadata_Release_Anon.csv
% Available at: https://sites.google.com/view/cnnp-lab//ideas-data

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 20);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["ID", "Sex", "Binned_Onset_Age", "FUS", "fqFUS", "FBTCS", "fqFBTCS", "SE", "Op_Side", "Op_Type", "Pathology", "OPMEMO", "Number_ASMs", "Binned_Age_at_Scan", "Binned_Age_at_Surgery", "ILAE_Year1", "ILAE_Year2", "ILAE_Year3", "ILAE_Year4", "ILAE_Year5"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "categorical", "double", "categorical", "double", "categorical", "categorical", "categorical", "categorical", "categorical", "double", "categorical", "categorical", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["ID", "Sex", "Binned_Onset_Age", "FUS", "FBTCS", "SE", "Op_Side", "Op_Type", "Pathology", "OPMEMO", "Binned_Age_at_Scan", "Binned_Age_at_Surgery"], "EmptyFieldRule", "auto");

% Import the data
Metadata = readtable("<path_to>/Metadata_Release_Anon.csv", opts);

%% Clear temporary variables
clear opts

%%
Metadata.Op_Type = string(Metadata.Op_Type);
Metadata.Op_Side = string(Metadata.Op_Side);
Metadata.ID = string(Metadata.ID);
Metadata.isControl = zeros(size(Metadata,1),1); 
Metadata(203,:) = []; % remove duplicative participant

%% Includes dual path as HS, excluding one case which does not actually have dual path (#431)
% Metadata.Pathology = mergecats(Metadata.Pathology,"DUAL","HS");
% Metadata.Pathology(Metadata.ID == "431") = 'OTHER'; % sub431 does not actually have dual path

%%
Metadata.Pathology1 = string(Metadata.Pathology);
Metadata.Op_Side1 = string(Metadata.Op_Side);
Metadata.Disease = strcat(Metadata.Op_Side1,"_",Metadata.Pathology1);
Metadata.Disease = categorical(Metadata.Disease);

%% Preserves original data with dual path treated as NOT HS
Metadata.Disease = mergecats(Metadata.Disease,...
    {'L_CAV','L_DNT','L_DUAL','L_FCD','L_GL','L_TBC','L_TREBLE','L_OTHER',...
    'R_CAV','R_DNT','R_DUAL','R_FCD','R_GL','R_TBC','R_TREBLE','R_OTHER'},...
    'OTHER');

%% Includes dual path as HS, excluding one case which does not actually have dual path (431)
% Metadata.Disease = mergecats(Metadata.Disease,...
%     {'L_CAV','L_DNT','L_FCD','L_GL','L_TBC','L_TREBLE','L_OTHER',...
%     'R_CAV','R_DNT','R_FCD','R_GL','R_TBC','R_TREBLE','R_OTHER'},...
%     'OTHER');

%%
Metadata = removevars(Metadata,["Pathology1","Op_Side1"]);

%% Import data from text file: Metadata_Controls_Release.csv

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["ID", "Sex", "Binned_Age_at_Scan"];
opts.VariableTypes = ["double", "categorical", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Sex", "Binned_Age_at_Scan"], "EmptyFieldRule", "auto");

% Import the data
Metadata_Controls_Release = readtable("<path_to>/Metadata_Controls_Release.csv", opts);

%% Clear temporary variables
clear opts

%%
Metadata_Controls_Release.ID = string(Metadata_Controls_Release.ID);
Metadata_Controls_Release.isControl = ones(size(Metadata_Controls_Release,1),1); 

%%
Metadata_Controls_Release.Disease = categorical(Metadata_Controls_Release.isControl);
Metadata_Controls_Release.Disease = renamecats(Metadata_Controls_Release.Disease,'Controls');

%%
save("meta_data.mat")