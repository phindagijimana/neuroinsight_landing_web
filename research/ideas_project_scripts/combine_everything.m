clc
clear

%%
load meta_data.mat
load aseg.mat

%%
path = Metadata(:,["ID","Op_Side","Pathology"]);

%%
Metadata = Metadata(:,["ID","Sex","Binned_Age_at_Scan","isControl","Disease"]);
Metadata = vertcat(Metadata,Metadata_Controls_Release);

%% Harmonize ages of patients and controls
Metadata.Binned_Age_at_Scan = mergecats(Metadata.Binned_Age_at_Scan,"15 to 20","Less than 20");
Metadata.Binned_Age_at_Scan = mergecats(Metadata.Binned_Age_at_Scan,["55 to 59","60 to 64","65 to 70"],"Over 55");
Metadata.Binned_Age_at_Scan = categorical(Metadata.Binned_Age_at_Scan,{'Less than 20','20 to 24','25 to 29','30 to 34','35 to 39','40 to 44','45 to 49','50 to 54','Over 55'});
Metadata.Binned_Age_at_Scan = double(Metadata.Binned_Age_at_Scan);
Metadata.Binned_Age_at_Scan = Metadata.Binned_Age_at_Scan-mean(Metadata.Binned_Age_at_Scan); % demeaned age

%%
data = innerjoin(Metadata,aseg_vol,"Keys","ID");

%% 
vars = data.Properties.VariableNames;

leftVars  = vars(startsWith(vars, 'Left_'));
rightVars = vars(startsWith(vars, 'Right_'));

% Remove prefixes
leftSuffix  = erase(leftVars, 'Left_');
rightSuffix = erase(rightVars, 'Right_');

% Find matching pairs by comparing suffixes
[commonSuffixes, idxL, idxR] = intersect(leftSuffix, rightSuffix);
for i = 1:length(commonSuffixes)
    L = data.(leftVars{idxL(i)});
    R = data.(rightVars{idxR(i)});
    
    AI = (L - R)./(L + R);  % asymmetry index
    
    % Create a new variable in the table
    newName = ['AI_' commonSuffixes{i}];
    data.(newName) = AI;
end

%%
save("data_all_unharmonized.mat","data","path")