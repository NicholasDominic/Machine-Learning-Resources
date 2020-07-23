# Import KERAS Library
library(keras)

fashion_mnist = dataset_fashion_mnist()
# Another way to do test_train_split
# c(x_train, y_train) %<-% fashion_mnist$train
# c(x_test, y_test) %<-% fashion_mnist$test
x_train = fashion_mnist$train$x
y_train = fashion_mnist$train$y
x_test = fashion_mnist$test$x
y_test = fashion_mnist$test$y

# Split train dataset into train and validation data
idx = 1:5000
x_train = x_train[-idx,,]
x_val = x_train[idx,,]
y_train = y_train[-idx]
y_val = y_train[idx]

# See dimension shape
dim(x_train)
dim(y_train)
dim(x_val)
dim(y_val)
dim(x_test)
dim(y_test)

# Create class_names
class_names = c("T-shirt/top", "Trouser/pants", "Pullover shirt", "Dress", "Coat", "Sandal", "Shirt", "Sneaker", "Bag", "Ankle boot")

# Plot a sample image
fobject = x_train[5,,] # fifth image with all its pixels
plot(as.raster(fobject, max=255)) # as raster image

# Normalization
x_train = x_train / 255
x_test = x_test / 255

# CLASSIFICATION USING KERAS SEQUENTIAL API
# Step 1: DEFINE THE MODEL (Keras Sequential)
model = keras_model_sequential()
model %>%
  layer_flatten(input_shape=c(28, 28)) %>%
  layer_dense(units=128, activation='relu') %>%
  layer_dense(units=10, activation='softmax')
model # see summary of the model, or summary(model)

# Step 2: COMPILE THE MODEL
model %>% compile(
  optimizer='sgd',
  loss='sparse_categorical_crossentropy',
  metrics=c('accuracy')
)

# Step 3: FIT THE MODEL
model %>% fit(
  x_train, y_train,
  epochs=30, batch_size=100,
  validation_data=list(x_val, y_val)
)

# Step 4: EVALUATE
score = model %>% evaluate(x_test, y_test)
paste0(sprintf("Loss: %.3f", score["loss"]*100), '%')
paste0(sprintf("Accuracy: %.3f", score["accuracy"]*100), '%')

# Step 5: PREDICTION
predict = model %>% predict(x_test)
dim(predict) # shape of (10000, 10) means 10000 images with 10 classess each
predict[1, ] # show 10 prediction probability of each class on the first image
predict[3, ] # show 10 prediction probability of each class on the third image

which.max(predict[1,]) # find the maximum prediction probability
class_names[which.max(predict[1,])] # get class name in string

class_predict = model %>% predict_classes(x_test)
dim(class_predict) # shape of (10000) means 10000 images with 1 class predicted
class_predict[1] # show that the first image is classified as class = 9
class_predict[3] # show that the third image is classified as class = 1

class_names[class_predict[1]+1] # +1 because R index starts from 1, not 0
class_names[class_predict[3]+1]

plot(as.raster(x_test[1,,], max=1)) # plot the predicted image