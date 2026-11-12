# =====================================================================
# Multispecies Diagnostic Records: Early Illness Detection
# Machine Learning Model & Feature Importance Analysis (Random Forest)
# =====================================================================

# 1. Load required libraries
library(randomForest)
library(ggplot2)
library(dplyr)

# 2. Load dataset (adjust path to your local file if necessary)
# model_data <- read.csv("data/zoo_health_cleaned.csv")

# 3. Standardize and format column names/categories (lowercase style)
# Ensuring data consistency and clean visual labels for the portfolio
colnames(model_data)[colnames(model_data) == "Daily_Steps"] <- "daily steps"
colnames(model_data)[colnames(model_data) == "Animal_Type"] <- "animal type"
colnames(model_data)[colnames(model_data) == "Body_Temperature_c"] <- "body temperature (°c)"
colnames(model_data)[colnames(model_data) == "Heart_Rate_bpm"] <- "heart rate (bpm)"
colnames(model_data)[colnames(model_data) == "Weight_kg"] <- "weight (kg)"
colnames(model_data)[colnames(model_data) == "Gender"] <- "gender"

# Ensure target variable (Health_Status) is a factor
model_data$Health_Status <- as.factor(model_data$Health_Status)

# 4. Train/Test Data Split (80/20 split)
set.seed(42)
train_index <- sample(nrow(model_data), 0.8 * nrow(model_data))
train_set <- model_data[train_index, ]
test_set  <- model_data[-train_index, ]

# 5. Train Random Forest Classification Model
set.seed(42)
rf_model <- randomForest(
  Health_Status ~ ., 
  data = train_set, 
  ntree = 100, 
  importance = TRUE
)

# Print model summary
print(rf_model)

# 6. Evaluate Model on Test Set (Accuracy Check)
predictions <- predict(rf_model, newdata = test_set)
confusion_matrix <- table(Predicted = predictions, Actual = test_set$Health_Status)
print(confusion_matrix)

# Calculate Accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Model Test Accuracy:", accuracy * 100, "%\n")

# 7. Extract Feature Importance Data for ggplot2
imp_df <- as.data.frame(importance(rf_model))
imp_df$Feature <- rownames(imp_df)

# 8. Clean and map feature labels to lowercase (safely matching variations)
imp_df <- imp_df %>%
  mutate(Feature = case_when(
    grepl("daily steps", Feature, ignore.case = TRUE) ~ "daily steps",
    grepl("animal type", Feature, ignore.case = TRUE) ~ "animal type",
    grepl("body temperature", Feature, ignore.case = TRUE) ~ "body temperature (°c)",
    grepl("heart rate", Feature, ignore.case = TRUE) ~ "heart rate (bpm)",
    grepl("weight", Feature, ignore.case = TRUE) ~ "weight (kg)",
    grepl("gender", Feature, ignore.case = TRUE) ~ "gender",
    TRUE ~ Feature
  ))

# 9. Generate Professional Feature Importance Plot (ggplot2)
ggplot(imp_df, aes(x = reorder(Feature, MeanDecreaseAccuracy), y = MeanDecreaseAccuracy)) +
  geom_point(color = "steelblue", size = 3) +
  geom_segment(aes(x = Feature, xend = Feature, y = 0, yend = MeanDecreaseAccuracy), 
               color = "steelblue", linewidth = 1) +
  coord_flip() +
  labs(
    title = "Feature importance - early illness detection",
    subtitle = "Random forest model (mean decrease accuracy)",
    x = "",
    y = "mean decrease accuracy"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray40"),
    axis.text.y = element_text(size = 11, color = "black")
  )

# 10. Save the high-resolution plot for the GitHub repository and PowerPoint presentation
# ggsave("plots/feature_importance.png", width = 8, height = 5, dpi = 300)