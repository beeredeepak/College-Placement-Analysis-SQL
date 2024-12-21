from xgboost import XGBClassifier

X = df[['cgpa', 'backlogs', 'intern_experience', 'branch', 'semester']]
y = df['placed']

# Encode categorical variables (e.g., branch)
X = pd.get_dummies(X)

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


# Create and train the XGBoost model
model = XGBClassifier()
model.fit(X_train, y_train)

# Make predictions on the test set
y_pred = model.predict(X_test)

# Evaluate the model's performance
print(classification_report(y_test, y_pred))