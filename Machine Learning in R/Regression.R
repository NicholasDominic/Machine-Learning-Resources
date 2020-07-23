library(keras)

house = dataset_boston_housing()
# Another way to do test_train_split
# c(x_train, y_train) %<-% house$train
# c(x_test, y_test) %<-% house$test
x_train = house$train$x
y_train = house$train$y
x_test = house$test$x
y_test = house$test$y

# Normalize x_train
x_train = scale(x_train)

# Normalize x_test using mean & stdev from x_train
x_test = scale(x_test, center=attr(x_train, "scaled:center"), scale=attr(x_train, "scaled:scale"))

# REGRESSION USING KERAS FUNCTIONAL API
# Step 1: DEFINE THE MODEL (Keras Functional consists of input+output)
inputs = layer_input(shape=dim(x_train)[2]) # take the second dimension since it represents total of variables == 13
hidden = inputs %>%
  layer_dense(64, activation='relu') %>%
  layer_dense(64, activation='relu')
target_output = layer_concatenate(c(hidden, inputs)) %>% layer_dense(1)

# Step 2: COMPILE THE MODEL
reg_model = keras_model(inputs=inputs, outputs=target_output)
reg_model %>% compile(
  optimizer='rmsprop',
  loss='mse',
  metrics=list('mean_absolute_error')
)
summary(reg_model) # summary of the current model, or simply type reg_model

# Step 3: FIT THE MODEL
reg_model %>% fit(x_train, y_train, epochs=30, batch_size=100)

# Step 4: EVALUATE WITH TEST DATA
score = reg_model %>% evaluate(x_test, y_test)
sprintf("Loss: %.3f", score["loss"])
sprintf("Mean Abs Error: %.3f", score["mean_absolute_error"])

# SAVE THE MODEL
reg_model %>% save_model_hdf5("model/regression-model-in-R.h5")

# RELOAD THE MODEL
reg_model_reload = load_model_hdf5("model/regression-model-in-R.h5")