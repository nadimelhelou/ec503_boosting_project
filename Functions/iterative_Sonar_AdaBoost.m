%% AdaBoost used on a small scale binary dataset (labels: +1 rock, -1 mine)

data = readmatrix('sonar_csv.xls');

n = size(data,1);
Ts = [1,3,5,7,10,20,50,100,300];
test_CCRs = zeros(numel(Ts),1);
train_CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);
data_train = data(randOrder(1:143),:);
data_test = data(randOrder(144:208),:);
all_gs = calculate_gs(data);

for i=1:numel(Ts)
    [alphas,classifiers]= AdaBoost(data_train,Ts(i), all_gs);
    test_CCRs(i,1) = test_our_boosted_classifier(data_test,alphas,classifiers);
    train_CCRs(i,1) = test_our_boosted_classifier(data_train,alphas,classifiers);
    
    if (i==9)
        create_confusion(data_tilted_test,alphas,classifiers);
    end

end
