# Decision Tree
A **Decision Tree** is a popular and intuitive supervised machine learning
algorithm used for both classification and regression tasks. It models decisions
and their possible consequences in a tree-like structure, making it easy to
interpret and visualize. Decision Trees are fundamental components in more
complex ensemble methods like Random Forests and Gradient Boosting Machines.


## Table of Contents
1. [What is a Decision Tree?](#what-is-a-decision-tree)
1. [Key Components](#key-components)
1. [How Decision Trees Work](#how-decision-trees-work)
1. [Impurity Measures](#impurity-measures)
   + [Gini Impurity](#gini-impurity)
   + [Entropy](#entropy)
   + [Mean Squared Error (for Regression)](#mean-squared-error-for-regression)
1. [Tree Building Process](#tree-building-process)
1. [Overfitting and Pruning](#overfitting-and-pruning)
1. [Advantages and Disadvantages](#advantages-and-disadvantages)
1. [Mathematical Formulation](#mathematical-formulation)
1. [References](#references)


## What is a Decision Tree?
A **Decision Tree** is a flowchart-like structure where each internal node
represents a **feature** (or attribute), each branch represents a **decision
rule**, and each leaf node represents an **outcome** (label). The paths from the
root to the leaf represent classification rules.

![Decision Tree Example](../resource/naive-decision-tree.png)

*Figure 1: Example of a Decision Tree for the Titanic Survival Dataset.*


## Key Components
+ **Root Node:** The topmost node representing the entire dataset, which gets
  split into subsets.
+ **Internal Nodes:** Nodes that represent tests on a feature.
+ **Branches:** Outcomes of a test that lead to other nodes or leaves.
+ **Leaf Nodes (Terminal Nodes):** Nodes that represent the final output or
  decision.
+ **Splitting:** The process of dividing a node into two or more sub-nodes.
+ **Pruning:** The process of removing sub-nodes to prevent overfitting.
+ **Depth:** The length of the longest path from the root to a leaf.


## How Decision Trees Work
1. **Select the Best Feature:** Choose the feature that best splits the data
   into target classes based on a certain criterion (e.g., Gini Impurity, Entropy).
1. **Split the Dataset:** Divide the dataset into subsets based on the selected
   feature.
1. **Repeat Recursively:** Apply the same process to each subset until:
   + All instances in a subset belong to the same class (pure node).
   + There are no remaining features to split.
   + A predefined stopping criterion is met (e.g., maximum depth).

This recursive partitioning results in a tree structure that can be used for
making predictions on new data.


## Impurity Measures
Impurity measures quantify the homogeneity of the target variable within the
subsets. Common measures include **Gini Impurity**, **Entropy**,
and **Mean Squared Error** (for regression).


### Gini Impurity
Gini Impurity measures the likelihood of incorrectly classifying a randomly
chosen element if it was randomly labeled according to the distribution of
labels in the subset.

$$
\text{Gini}(D) = 1 - \sum_{i=1}^{K} p_i^2
$$

Where:
  + $D$: Dataset.
  + $K$: Number of classes.
  + $p_i$: Proportion of instances belonging to class $ i $.

**Example:**
For a binary classification ($K=2$) with $p_1 = 0.6$ and $p_2 = 0.4$:

$$
\text{Gini}(D) = 1 - (0.6^2 + 0.4^2) = 1 - (0.36 + 0.16) = 0.48
$$


### Entropy
Entropy measures the amount of uncertainty or disorder within the dataset.

$$
\text{Entropy}(D) = -\sum_{i=1}^{K} p_i \log_2 p_i
$$

+ Higher entropy indicates more disorder.

**Example:**
For the same binary classification:

$\text{Entropy}(D) = - (0.6 \log_2 0.6 + 0.4 \log_2 0.4) \approx 0.971$


### Mean Squared Error (for Regression)
For regression tasks, **Mean Squared Error (MSE)** is commonly used as an
impurity measure.

$$
\text{MSE}(D) = \frac{1}{|D|} \sum_{i=1}^{|D|} (y_i - \hat{y})^2
$$

+ $y_i$: Actual value.
+ $\hat{y}$: Predicted value (e.g., mean of the target values in the subset).


## Tree Building Process
1. **Start at the Root:** Compute the impurity measure for the entire dataset.
1. **Find the Best Split:** For each feature, evaluate possible splits and
   calculate the impurity for each resulting subset.
1. **Choose the Optimal Split:** Select the feature and split that minimizes the
   weighted impurity of the child nodes.
1. **Create Sub-Nodes:** Divide the dataset into subsets based on the optimal
   split and create corresponding child nodes.
1. **Repeat Recursively:** Apply the same process to each child node until
   stopping criteria are met.


### Example Workflow
1. **Initial Dataset:**
   + Classes: A, B, C
   + Compute Gini Impurity.
1. **Evaluate Feature Splits:**
   + Feature 1: Possible splits → Calculate Gini for each subset.
   + Feature 2: Possible splits → Calculate Gini for each subset.
   + ...
1. **Select Best Split:** Choose the feature and split with the lowest weighted
   Gini Impurity.
1. **Split and Create Child Nodes:** Repeat the process for each child node.


## Overfitting and Pruning
**Overfitting** occurs when the decision tree becomes too complex, capturing
*noise in the training data and performing poorly on unseen data.


### Pruning Techniques

1. **Pre-Pruning (Early Stopping):**
   + Limit the maximum depth of the tree.
   + Require a minimum number of samples per leaf.
   + Set a minimum impurity decrease to allow a split.
1. **Post-Pruning:**
   + Allow the tree to grow fully.
   + Remove branches that have little importance based on a validation set.

Pruning helps in creating a simpler model that generalizes better to new data.


## Advantages and Disadvantages


### Advantages
+ **Interpretability:** Easy to visualize and understand.
+ **No Need for Feature Scaling:** Handles both numerical and categorical data.
+ **Handles Non-linear Relationships:** Can capture complex patterns.
+ **Requires Little Data Preparation:** Minimal preprocessing required.


### Disadvantages
+ **Overfitting:** Prone to creating overly complex trees.
+ **Instability:** Small changes in data can lead to different trees.
+ **Bias Towards Features with More Levels:** Can favor features with many
  categories.
+ **Limited Expressiveness:** May not capture all patterns, especially in
  high-dimensional spaces.


## Mathematical Formulation


### Splitting Criterion
The goal is to choose splits that maximize the **information gain** (for
entropy) or **Gini gain** (for Gini Impurity).

$$
\text{Information Gain} = \text{Entropy(parent)} - \sum_{j=1}^{J} \frac{|D_j|}{|D|} \text{Entropy}(D_j)
$$

$$
\text{Gini Gain} = \text{Gini(parent)} - \sum_{j=1}^{J} \frac{|D_j|}{|D|} \text{Gini}(D_j)
$$

Where:
  + $D$: Parent dataset.
  + $D_j$: Subset after split $ j $.
  + $J$: Number of subsets after the split.


### Decision Boundary
In classification, the decision tree partitions the feature space into regions
corresponding to different classes. The boundaries are axis-aligned, meaning
they are perpendicular to feature axes.


### Prediction
+ **Classification:** Assign the class with the majority vote in the leaf node.
+ **Regression:** Assign the mean or median value of the target variable in the
  leaf node.


## References
1. **Scikit-learn Documentation:**
   + [Decision Trees](https://scikit-learn.org/stable/modules/tree.html)
   + [Tree-based models](https://scikit-learn.org/stable/modules/tree.html#tree)
1. **Books:**
   + **"The Elements of Statistical Learning"** by Trevor Hastie, Robert
     Tibshirani, and Jerome Friedman.
   + **"Pattern Recognition and Machine Learning"** by Christopher M. Bishop.
1. **Online Resources:**
   + [Wikipedia: Decision Tree](https://en.wikipedia.org/wiki/Decision_tree_learning)
   + [Towards Data Science: Decision Trees Explained](https://towardsdatascience.com/decision-trees-in-machine-learning-641b9c4e8052)
1. **Research Papers:**
   + **CART: Classification and Regression Trees**, Breiman et al., 1984.
