function MCDdemo
clc;
% load data
Loaddata = load('LandmineData.mat');
feature = Loaddata.feature;
label = Loaddata.label;
Threshold = 30;

% defing training set and test set
training_data = cell(1,2);
training_label = cell(1,2);
training_data{1} = [];
training_data{2} = [];
training_label{1} = [];
training_label{2} = [];
test_data = cell(1,2);
test_label = cell(1,2);
test_data{1} = [];
test_data{2} = [];
test_label{1} = [];
test_label{2} = [];

for j = 1:10
    training_data{1} = [training_data{1};feature{j}];
    training_label{1} = [training_label{1};label{j}]; 
end
for j = 11:15
    test_data{1} = [test_data{1};feature{j}];
    test_label{1} = [test_label{1};label{j}];
end
for j = 16:25
    training_data{2} = [training_data{2};feature{j}];
    training_label{2} = [training_label{2};label{j}];
end
for j = 26:29
    test_data{2} = [test_data{2};feature{j}];
    test_label{2} = [test_label{2};label{j}];
end

% prompt
MENU_train = 'Select training data set\n1:data set 1~10\n2:data set 16~25\n0:exit\n';
MENU_test = 'Select test data set\n1:data set 11~15\n2:data set 26~29\n0:exit\n';

train = 3;
test = 3;

while train ~= 0 && train ~= 1 && train ~= 2
    fprintf('-----------------------------------------\n')
    fprintf('|           CHOOSE TRAIN DATA           |\n')
    fprintf('-----------------------------------------\n')
    train = input(MENU_train);
    if train == 0
        fprintf('Exit!\n')
        return
    elseif train ~= 0 && train ~= 1 && train ~= 2
        fprintf(2,'Select an valid options!\n')
    end
end

while test ~= 0 && test ~= 1 && test ~= 2
    fprintf('-----------------------------------------\n')
    fprintf('|           CHOOSE TEST DATA            |\n')
    fprintf('-----------------------------------------\n')
    test = input(MENU_test);
    if test == 0
        fprintf('Exit!\n')
        return
    elseif test ~= 0 && test ~= 1 && test ~= 2
        fprintf(2,'Select an valid options!\n')
    end
end

while test ~= 0
    skip_pules = 0;
    if test == 1 || test == 2
        % training and testing
        Theta = mnrfit(training_data{train},training_label{train}+1);
        Theta_test = mnrfit(test_data{test},test_label{test}+1);
        P = mnrval(Theta,test_data{test});
        [~,pre_label]=max(P,[],2);
        pre_label = pre_label - 1;
        accuracy = (1/length(test_label{test}))*sum(pre_label == test_label{test});
        JS = JSdivergence(Theta,Theta_test,[training_data{train};training_data{test}]);
        % print result
        fprintf('-----------------------------------------\n')
        fprintf('|                 RESULT                |\n')
        fprintf('-----------------------------------------\n')
        if train == 1
            fprintf('Training set = 1~10\n')
        else
            fprintf('Training set = 16~25\n')
        end
        if test == 1
            fprintf('Testing set = 11~15\n')
        else
            fprintf('Testing set = 26~29\n')
        end
        fprintf('Accuracy = %4.2f%%\n',accuracy*100)
        fprintf('JS divergence = %4.2f\n',JS)
        % Model Change Detection
        if JS > Threshold
            skip_pules = 1;
            fprintf('-----------------------------------------\n')
            fprintf('|        MODEL CHANGE DETECTED          |\n')
            fprintf('-----------------------------------------\n')
            fprintf('JS divergence value %4.2f is larger then the given threshold %d.\n',JS,Threshold) 
            fprintf('The model has changed!\n')
            if train == 1
                quitok = 0;
                while quitok ~= 1
                    answer = input('Would you like to re-train the model using data set 16~25? (y/n)\n','s');
                    if strcmp(answer,'y') || strcmp(answer,'yes')
                        train = 2;
                        quitok = 1;
                        fprintf('The model has been re-train, now test it again!\n')
                    elseif strcmp(answer,'n') || strcmp(answer,'no')
                        train = 1;
                        quitok = 1;
                        fprintf('Keeping the original model!\n')
                    else
                        fprintf(2,'Select an valid options\n')
                    end
                end
            else
                quitok = 0;
                while quitok ~= 1
                    answer = input('Would you like to re-train the model using data set 1~10? (y/n)\n','s');
                    if strcmp(answer,'y') || strcmp(answer,'yes')
                        train = 1;
                        quitok = 1;
                        fprintf('The model has been re-train, now test it again!\n')
                    elseif strcmp(answer,'n') || strcmp(answer,'no')
                        train = 2;
                        quitok = 1;
                        fprintf('Keeping the original model!\n')
                    else
                        fprintf(2,'Select an valid options\n')
                    end
                end
            end
        end
    else
        fprintf(2,'Select an valid options\n')
        skip_pules = 1;
    end
    if ~skip_pules
        temp = input('Press ENTER to continue or CTRL+C to quit...');
    end
    fprintf('-----------------------------------------\n')
    fprintf('|           CHOOSE TEST DATA            |\n')
    fprintf('-----------------------------------------\n')
    test = input(MENU_test);
end

fprintf('Exit!\n')
end