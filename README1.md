# 🐾 Multispecies Diagnostic Records: Early Illness Detection

An end-to-end data science and analytics project focused on multi-sensor health monitoring and predictive modeling for exotic species. This project bridges SQL data engineering, business intelligence (Excel), and machine learning (R) to detect early signs of illness based on behavioral and physiological telemetry.

---

## 🚀 Project Overview
In zoological and conservation environments, detecting illnesses before clinical symptoms become severe is critical. This project processes a multi-sensor dataset containing **15,000 records across 32 exotic species** to train a classification model capable of distinguishing between healthy and sick subjects with high precision.

### **The Data Pipeline (Tech Stack):**
1. **Data Engineering (SQL/SQLite):** Cleaning logs, standardizing data types, and aggregating records.
2. **Exploratory Data Analysis (Excel):** Establishing species-level physiological baselines via Pivot Tables.
3. **Predictive Modeling (RStudio):** Training a supervised machine learning model and visualizing feature importance using `ggplot2`.

---

## 📊 Key Results & Model Performance

The predictive model was built using a **Random Forest Classifier** (80/20 train-test split, 100 decision trees).

| Metric / Parameter | Result / Value | Description |
| :--- | :--- | :--- |
| **Model Type** | Random Forest Classifier | Supervised classification (`ntree = 100`) |
| **Test Accuracy** | **100% (1.0)** | Perfect classification rate on unseen testing data |
| **Top Predictor** | `daily steps` | Behavioral shifts serve as the primary early indicator |
| **Secondary Features** | `animal type`, `body temperature` | Provide essential species context and physiological baselines |

---

## 📈 Feature Importance Analysis

To evaluate which metrics drive early illness detection, we analyzed variable importance measured by **Mean Decrease Accuracy** (the drop in model accuracy when a feature's data is shuffled).

![Feature Importance Plot](plots/feature_importance.png)

* **`daily steps` (Top Predictor):** Ranks highest, proving that tracking physical activity changes is critical for early detection.
* **`animal type` & `body temperature (°c)`:** Provide necessary physiological baselines across diverse species.
* **`gender` (Negligible Impact):** Shows near-zero importance, confirming it does not drive health status predictions in this model.

---

## 💡 Key Insights & Business Decisions

* **Behavioral Early Warnings:** Sudden drops in daily activity (`daily steps`) precede severe physiological deterioration, shifting veterinary care from *reactive* treatment to *proactive* prevention.
* **Species Context:** Factoring in `animal type` prevents false alarms by establishing accurate, species-specific physiological thresholds.
* **Resource Optimization:** Directing veterinary diagnostics primarily to subjects flagged by behavioral anomalies optimizes facility labor and resources.

---

## 📁 Repository Structure
```text
├── data/                  # Cleaned datasets (.csv)
├── sql/                   # SQL queries and database views
├── r_scripts/             # R scripts for Random Forest modeling & ggplot2
├── plots/                 # Generated visualizations and charts
└── README.md              # Project documentation
