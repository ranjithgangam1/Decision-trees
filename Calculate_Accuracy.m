function  [Accuracy]  = Calculate_Accuracy( PredictLabels,TestLabels )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

TP = 0
TN = 0
FP = 0
FN = 0

for i=1:length(PredictLabels)
     if PredictLabels(i)==1 && TestLabels(i)==1
         TP = TP + 1
     elseif PredictLabels(i)==0 && TestLabels(i)==1
          FN = FN + 1
     elseif PredictLabels(i)==1 && TestLabels(i)==0
          FP = FP + 1
     else
         TN = TN + 1
     end
end
  
           
 Accuracy = (TP + TN)/(TP+TN+FP+FN)
 Precision = TP/(TP+FP)
 Recall = TP/(TP+FN)
 

end




