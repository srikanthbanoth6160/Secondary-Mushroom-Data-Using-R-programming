### ἳ1 Secondary Mushroom Data Set
A machine learning project to classify mushrooms as **edible** or **poisonous** using various classification models.

## 🚀 Features
- **Preprocessing:** Handling categorical features, encoding, and feature selection
- **Machine Learning Models:**  
  - **Logistic Regression**  
  - **Linear Discriminant Analysis (LDA)**  
  - **Quadratic Discriminant Analysis (QDA)**  
  - **Naïve Bayes**  
- **Evaluation Metrics:** Accuracy, AIC, BIC, ROC curves, and AUC scores

## 📂 Dataset
- **Source:** [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Secondary+Mushroom+Dataset)
- **Instances:** 61,069 mushroom samples
- **Attributes:** 21 features, including:
  - Cap shape, cap color, gill size, stem shape, etc.
  - Habitat and season
  - Target variable: **"e" (edible) or "p" (poisonous)**

## 📊 Results
| Model | AIC | BIC | Accuracy |
|--------|------|------|-----------|
| Logistic Regression | 74,731 | 74,938.31 | 0.6692 |
| LDA | - | - | 0.6658 |
| QDA | - | - | 0.6516 |
| Naïve Bayes | - | - | 0.6011 |

- **Reduced Model:**
  - Selected **7 key features** for improved performance
  - **AUC Scores:** Logistic Regression & LDA (0.7196), QDA (0.7147), Naïve Bayes (0.681)

## 📍 Challenges
- Handling high dimensionality and nonlinearity
- Selecting the optimal predictor variables
- Balancing model accuracy and complexity

## 🎯 Future Improvements
- Hyperparameter tuning to optimize model accuracy
- Incorporating deep learning techniques
- Deployment as a **real-time mushroom classification tool**
- Developing predictive models for **food safety applications**

## 👨‍💻 Author
- **Srikanth Banoth**
