The terrorist detection task is an imbalanced classification problem: we have two classes we need to identify—terrorists and not terrorists—with one category (non-terrorists) representing the overwhelming majority of the data points. Another imbalanced classification problem occurs in disease detection when the rate of the disease in the public is very low. In both these cases, the positive class—disease or terrorist—greatly outnumbers the negative class. These types of problems are examples of the fairly common case in data science when accuracy is not a good measure for assessing model performance.

Recall: The ability of a model to find ALL the relevant cases within a data set. Mathematically, we define recall as the number of true positives divided by the number of true positives plus the number of false negatives,.i.e., reported real positive / total real positive

Precision: The ability of a classification model to identify ONLY the relevant data points. Mathematically, precision the number of true positives divided by the number of true positives plus the number of false positives. i.e., reported real positve / all reported postive

True positives are data points classified as positive by the model that actually are positive (meaning they are correct), and false negatives are data points the model identifies as negative that actually are positive (incorrect). In the terrorism case, true positives are correctly identified terrorists, and false negatives would be individuals the model labels as not terrorists that were, in fact, terrorists

The F1 score is the harmonic mean of precision and recall = 2 * (precision * recall) / precision + recall

We use the harmonic mean instead of a simple average because it punishes extreme values. A classifier with a precision of 1.0 and a recall of 0.0 has a simple average of 0.5 but an F1 score of 0.

A ROC curve plots the true positive rate on the y-axis versus the false positive rate on the x-axis. The true positive rate (TPR) is the recall, and the false positive rate (FPR) is the probability of a false alarm. The black diagonal line indicates a random classifier

Finally, we can quantify a model’s ROC curve by calculating the total Area Under the Curve (AUC), a metric that falls between zero and one with a higher number indicating better classification performance. A random classifier (the black line) achieves an AUC of 0.5.

