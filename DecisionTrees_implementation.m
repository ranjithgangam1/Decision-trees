
input = xlsread('D:\MS_documents\Meng\IDA\magic04.xlsx');

%sorts randomly
% Splitting data into 3 sections randomly. Training, Testing and
% validations are random split sections
random_in = randperm(19020); 
training = input(random_in(1:13020),1:11);
validation = input(random_in(16021:19020),1:11);
Testing = input(random_in(13021:16020),1:11); 

%Question 2
%features table
%spliiting training table into two tables first 10 cols into features and
%last column into class labels
 Features = training(:,1:10);
 ClassLabels= training(:,11);
 
 %Question 3
 %Creates decision tree
 dtr = fitctree(Features, ClassLabels, 'MinLeafSize', 1200)
 %Displays decision tree
 view(dtr,'Mode','graph')
 
%Question 4
%spliiting testing table into two tables first 10 cols into features and
%last column into class labels

 TestFeatures = Testing(:,1:10)
 TestClassLabels= Testing(:,11)
 PredictLabels = predict(dtr, TestFeatures)

  %function count counts number of records in testing table. Function count code is attached at the end of program 
  count = 0;
  count = fn_count(Testing);
  %Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
  %Calculate_Quality function code is attached end
[TP1,TN1,FP1,FN1,Accuracy1,Precision1,Recall1] = Calculate_Quality(PredictLabels,TestClassLabels,count);

%Question 5 a
%Creates decision tree for min leaf size of 1000
dtr_5 = fitctree(Features, ClassLabels, 'MinLeafSize', 1000)
   view(dtr_5,'Mode','graph')
   
 %Question 5 b   
 PredictLabels_5 = predict(dtr_5, Features)
  count = 0;
  count = fn_count(training);
 %Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
  %Calculate_Quality function code is attached end
  [TP,TN,FP,FN,Accuracy,Precision,Recall] = Calculate_Quality(PredictLabels_5,ClassLabels,count);
%creating table and writing TP TN FP FN Accuracy precision and recall to
%table
 tab = table(TP,TN,FP,FN,Accuracy,Precision,Recall)
 display(tab)

 
 %Question 5 C
%spliiting validation table into two tables first 10 cols into features and
%last column into class labels

ValidationFeatures= validation(:,1:10)
ValidationClassLabels= validation(:,11)
%predicting validation class
ValidateLabels = predict(dtr_5, ValidationFeatures)

  count = fn_count(validation);
 %Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
  %Calculate_Quality function code is attached end
  [TP,TN,FP,FN,Accuracy,Precision,Recall] = Calculate_Quality(ValidateLabels,ValidationClassLabels,count);

%creating table and writing TP TN FP FN Accuracy precision and recall to
%table
 tab = table(TP,TN,FP,FN,Accuracy,Precision,Recall)
 display(tab)
 
 
%Question 6
dtr_6 = fitctree(Features, ClassLabels, 'MinLeafSize', 20)
   view(dtr_6,'Mode','graph')
   
 %Question 6 b   
 PredictLabels_5 = predict(dtr_6, Features)
  count = 0;
  count = fn_count(training);
 %Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
  %Calculate_Quality function code is attached end
  [TP,TN,FP,FN,Accuracy,Precision,Recall] = Calculate_Quality(PredictLabels_5,ClassLabels,count);
%creating table and writing TP TN FP FN Accuracy precision and recall to
%table
 tab = table(TP,TN,FP,FN,Accuracy,Precision,Recall)
 display(tab)

 %6C
%predicting validation class
ValidateLabels = predict(dtr_6, ValidationFeatures)

 count = fn_count(validation);
 %Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
 %Calculate_Quality function code is attached end
 [TP,TN,FP,FN,Accuracy,Precision,Recall] = Calculate_Quality(ValidateLabels,ValidationClassLabels,count);

%creating table and writing TP TN FP FN Accuracy precision and recall to
%table
 tab = table(TP,TN,FP,FN,Accuracy,Precision,Recall)
 display(tab)
 
  
   
 %Question 7
 % All min leaf nodes are taken into array
Leaf_nodes = [1000,750,500,250,125,100,50,20,10,5]

% loop to create decision tree, predict labels and calculate quality
% measures
for i=1:length(Leaf_nodes)
  % creating tree  
  dtr_Trainig = fitctree(Features, ClassLabels, 'MinLeafSize', Leaf_nodes(i))
  % counting no.of nodes
Node_count(i) = dtr_Trainig.NumNodes
   TrainingLabels = predict(dtr_Trainig, Features);
   validationLabels = predict(dtr_Trainig, ValidationFeatures);
   
  Accuracy_Training(i) = Calculate_Accuracy(TrainingLabels,ClassLabels);
%validation data
 Accuracy_Validation_Arr(i) = Calculate_Accuracy(validationLabels,ValidationClassLabels);
%Test data

end
% plotting output in figure 1
figure(1)
% plotting Leaf_nodes,Accuracy_Training,Leaf_nodes,Accuracy_Validation_Arr
% in graph
plot(Leaf_nodes,Accuracy_Training,Leaf_nodes,Accuracy_Validation_Arr);
%sorting from 1000 min nodes to 0
set(gca,'xdir','rev')
% Giving lables to axis
 xlabel('Leaf nodes')
 ylabel('Accuracy');
 % creating legends
legend('AccuracyTraining','Accuracy Validation')
 figure(2)
 
 %ploting min leaf nods and count 
 plot(Leaf_nodes,Node_count)
 xlabel('Leaf nodes')
 ylabel('Node_count');
 
 %Question 8
 
 % decision tree with 50 nodes is better. Leaf nodes count 95
 
 TestFeatures = Testing(:,1:10)
 TestClassLabels= Testing(:,11)
 % calling fitctree at min leaf =50
 dtr_Trainig = fitctree(Features, ClassLabels, 'MinLeafSize', 50)
 Total_No_of_Nodes = dtr_Trainig.NumNodes
 PredictTestLabels = predict(dtr_Trainig, TestFeatures)
  count = 0;
 count = fn_count(Testing);
%Calculate_Quality calculates TP,TN,FP,FN, Accuracy,Precision,Recall.
%Calculate_Quality function code is attached end 
 [TP_test,TN_test,FP_test,FN_test,Accuracy_test,Precision_test,Recall_test] = Calculate_Quality(PredictTestLabels,TestClassLabels,count);
%creating table and writing TP TN FP FN Accuracy precision and recall to
%table
tab = table(TP_test,TN_test,FP_test,FN_test,Accuracy_test,Precision_test,Recall_test,Total_No_of_Nodes)
 display(tab)
 
 