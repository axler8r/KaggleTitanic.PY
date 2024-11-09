---
authors: [AxlR8R.io]
tags:    kaggle, titanic, machine-learning, python
tldr:    This repository explores the Python machine learning echo system for
         the Kaggle Titanic competition.
license: MIT
---


# Kaggle Titanic

This repository explores the Python machine learning echo system for the
[Kaggle Titanic competition](https://www.kaggle.com/competitions/titanic).

Solutions are implemented using decision tree, gradient boosting, and neural
network classifiers.



## Technologies

The main Python machine learning technologies used for the implemnttions are:
+ [Polars](https://docs.pola.rs/) for data manipulation
+ [NumPy](https://numpy.org/) for numerical operations
+ [scikit-learn](https://scikit-learn.org/stable/) for decision tree classifier
+ [XGBoost](https://xgboost.readthedocs.io/en/stable/) for gradient boosting classifier
+ [PyTorch](https://pytorch.org/) for neural network classifier
+ [seaborn](https://seaborn.pydata.org/) for plotting



## Directory Structure

+ Read the [documentation](documentation/_index.md).
+ Explore the [notebooks](notebook/_index.ipynb).
+ Explore the [source code](titanic/__init__.py).



## Hardware

This was developed on a cuda enabled machine. GPU acceleration is used for the
gradient boosting classifier and neural network classifier.



## License

This project is licensed under the terms of the
[MIT license](https://choosealicense.com/licenses/mit/).

