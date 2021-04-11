# MIDAS@IIITD Summer Internship 2021
My attempt at Task 3 (NLP) for MIDAS@IIITD Summer Internship 2021 program. The goal of the task is to predict the primary category of a product using primarily the description of the product.

## Data Preparation
### Labels
- The dataset does not directly have a primary category attribute. However, it contains an attribute named `product_category_tree` using which the primary category can be extracted.
- I noticed that a few products are not assigned to a primary category. I have grouped such products together and dropped the corresponding rows.
- Further, the dataset is very imbalanced.
  - Approximately 30% of the products belong to the 'Clothing' category and so on.
  - Thus, I have only focused on the top 15 categories in decreasing order of their product counts.
  - Adding more categories will lead to a decrease in accuracy due to the lack of training examples for such categories.
  - On the other hand, if we consider only top 5 or top 10 categories, we can improve the accuracy.

### Description
- The description has been preprocessed as follows:
  - Remove any non-alphabetic characters and extra whitespaces.
  - Convert the strings to lowercase.
  - Remove stopwords from the strings.
    - I have used stopwords from the `spaCy` library for this.
- `preprocessed.csv` obtained after the preprocessing is used for the `LSTM` and `BERT` models. It contains only two attributes, `primary_category` and `description`.

### Insights and Visualisations
- I have mainly focused on two visualisations:
  - Category-wise product counts
    - Through this, I was able to eliminate categories with very low counts that would possibly decrease the classifier's accuracy.
  - Category-wise average description lengths
    - This gives us some insight into the way products of different categories are described.
    - Categories like 'Automotive' and 'Computers' have very lenghty descriptions on average. This can be attributed to the need for technical specifications for such products.
- I have also used the `Scattertext` library to find the terms most associated with different categories.

## Models and Results
- I have considered three different models for the classification task, a traditional ML model, a sequence model, and a transformers model. 
- The experiments have been conducted with a Train:Test split of 80:20. 
- The reported metrics correspond to the test set.
- Metrics used:
  - Mean accuracy
  - Weighted F1 -> since the dataset is imbalanced

### Naive Bayes Classifier
- I have considered two variants:
- Count Vectorizer
  - Mean Accuracy: 95.759%
  - Weighted F1: 95.583%
- TF-IDF
  - Mean Accuracy: 89.848%
  - Weighted F1: 88.623%

### LSTM Classifier
- I have used a model with 3 bidirectional LSTM layers. The loss function used is `CrossEntropyLoss` and the optimiser used is `Adam`.
- The model was trained for 25 epochs on Google Colab.
- Results:
  - Mean Accuracy: 97.433%
  - Weighted F1: 97.484%
- To increase the accuracy further:
  - Since the average length of descriptions is > 300 (approximately 315), it is possible that the LSTM is unable to capture all of the relevant information.
  - As a result, we can experiment by increasing the number of layers as well as the hidden dimension size.
  - However, a better way to go about this would be by introducing attention mechanisms so that the model gives a higher weight to terms that are more associated with their respective categories.

### BERT Classifier
- I have fine-tuned `bert-base-uncased` model obtained from `transformers` library along with the corresponding tokenizer.
- The model was trained for just one epoch on Google Colab.
- Results:
  - Mean Accuracy: 94.058%
  - Weighted F1: 93.660%
- To increase the accuracy further:
  - Train for more epochs.

## Instructions to Run
1) Clone the repository: `git clone `
2) Run the bash script to create a new virtual environment and install required libraries: `./setup.sh`
3) Run `naive_bayes.ipynb` first since it also contains the exploration and visualisation code.

## Resources
- [Text Preprocessing](https://medium.com/@datamonsters/text-preprocessing-in-python-steps-tools-and-examples-bf025f872908)
- [NLP Visualisations](https://medium.com/plotly/nlp-visualisations-for-clear-immediate-insights-into-text-data-and-outputs-9ebfab168d5b)
- [Naive Bayes for Text Classification](https://towardsdatascience.com/text-classification-using-naive-bayes-theory-a-working-example-2ef4b7eb7d5a)
- [LSTM for Text Classification](https://towardsdatascience.com/multiclass-text-classification-using-lstm-in-pytorch-eac56baed8df)
- [Fine-tuning BERT for Text Classification](https://www.analyticsvidhya.com/blog/2020/07/transfer-learning-for-nlp-fine-tuning-bert-for-text-classification/)
