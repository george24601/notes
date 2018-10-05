#Suppose that a test for using a particular drug is 99% sensitive and 99% specific. That is, the test will produce 99% true positive results for drug users and 99% true negative results for non-drug users. Suppose that 0.5% of people are users of the drug. What is the probability that a randomly selected individual with a positive test is a drug user?

P(drug | positive) = P(positive | drug) * P(drug) / P(positive) = 0.99 * 0.995/ (P(positive | drug) * P(drug) + P(positvie | no-drug) * P(no-drug))

#The entire output of a factory is produced on three machines. The three machines account for 20%, 30%, and 50% of the factory output. The fraction of defective items produced is 5% for the first machine; 3% for the second machine; and 1% for the third machine. If an item is chosen at random from the total output and is found to be defective, what is the probability that it was produced by the third machine?

P(third | def) = P(def | third) * P(third) /P(def) = 0.01 * 0.5 / 0.2 * 0.05 + 0.3 * 0.03 + 0.5 * 0.01
