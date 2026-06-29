clc
clear

%%
rng("default")

%% Define function to roc metrics
function stats = compute_roc(labels,scores,pos_class)

    [X,Y,T,AUC,optrocpt] = perfcurve(labels,scores,pos_class,'NBoot',1000);
    sensitivity = optrocpt(2);
    specificity = 1-optrocpt(1);
    dist = (X(:,1) - optrocpt(1)).^2 + (Y(:,1) - optrocpt(2)).^2;
    [~, idx] = min(dist);
    threshold = T(idx);
    stats = [sensitivity,specificity,AUC,threshold];

end

%% Define function to calculate sensitivity and specificity for bootci
function stats = compute_sensspec(labels,scores,pos_class)

    [~,~,~,~,optrocpt] = perfcurve(labels,scores,pos_class);
    sensitivity = optrocpt(2);
    specificity = 1-optrocpt(1);
    stats = [sensitivity,specificity];

end

%% Define function for 5 fold CV
function stats = compute_cv(labels,scores,pos_class)

    % Create stratified partition
    numFolds = 5;
    cv = cvpartition(labels,'KFold',numFolds);
    optimalThresholds = zeros(numFolds,1);

    for k = 1:numFolds

        % Stratified test indices for fold k
        testIdx = test(cv,k);
        scores_k = scores(testIdx);
        labels_k = labels(testIdx);

        % ROC curve
        [X,Y,T,~,optrocpt] = perfcurve(labels_k,scores_k,pos_class);

        % Find OOP
        dist = (X(:,1) - optrocpt(1)).^2 + (Y(:,1) - optrocpt(2)).^2;

        % Optimal threshold index
        [~, idx] = min(dist);

        % Store results
        optimalThresholds(k) = T(idx);
    end
    
    % Aggregate results
    meanThreshold = mean(optimalThresholds);
    minThreshold = min(optimalThresholds);
    maxThreshold = max(optimalThresholds);

    stats = [meanThreshold,minThreshold,maxThreshold];
    
end

%% 
load data_all_unharmonized.mat

%% regress age/sex and get residuals
control_data = data(data.Disease == "Controls",:);
mdl = fitrgam(control_data,'AI_Hippocampus ~ Binned_Age_at_Scan + Sex',CategoricalPredictors='Sex');
data.aiR = data.AI_Hippocampus-predict(mdl,data);

%% get z-score 
data.z_ai = (data.aiR-mean(data.aiR(data.Disease == "Controls")))/std(data.aiR(data.Disease == "Controls"));

%%
data = innerjoin(data,path,"Keys","ID");

%% Define positive cases as those with HS on the operative side
L_HS = (data.Op_Side == 'L') & (data.Pathology == 'HS'); 

%%
stats = compute_roc(L_HS,data.z_ai,"false");
fprintf('Left HS \n')
fprintf('AUC (CI): %.2f (%.2f - %.2f) \n',stats(3),stats(4),stats(5))
ci = bootci(1000,@(x,y,z) compute_sensspec(x,y,z),L_HS,data.z_ai,0);
fprintf('Sensitivity (CI): %.2f (%.2f - %.2f)\n',stats(1),ci(1,1),ci(2,1))
fprintf('Specificity (CI): %.2f (%.2f - %.2f)\n',stats(2),ci(1,2),ci(2,2))
fprintf('Overall Threshold: %.3f\n',stats(6))
stats = compute_cv(L_HS,data.z_ai,"false");
fprintf('Mean Threshold (5 fold CV): %.3f\n',stats(1));
fprintf('Range Threshold (5 fold CV): %.3f to %.3f \n',stats(2),stats(3));

%% Define positive cases as those with HS on the operative side
R_HS = (data.Op_Side == 'R') & (data.Pathology == 'HS'); 

%% 
stats = compute_roc(R_HS,data.z_ai,"true");
fprintf('Right HS \n')
fprintf('AUC (CI): %.2f (%.2f - %.2f) \n',stats(3),stats(4),stats(5))
ci = bootci(1000,@(x,y,z) compute_sensspec(x,y,z),R_HS,data.z_ai,1);
fprintf('Sensitivity (CI): %.2f (%.2f - %.2f)\n',stats(1),ci(1,1),ci(2,1))
fprintf('Specificity (CI): %.2f (%.2f - %.2f)\n',stats(2),ci(1,2),ci(2,2))
fprintf('Overall Threshold: %.3f\n',stats(6))
stats = compute_cv(R_HS,data.z_ai,"true");
fprintf('Mean Threshold (5 fold CV): %.3f\n',stats(1));
fprintf('Range Threshold (5 fold CV): %.3f to %.3f \n',stats(2),stats(3));