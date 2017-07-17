# Iris (flower) A simple demo using Core ML in Swift 
Iris flower Dataset :Suggests flower name based on inputs parameters like .(https://en.wikipedia.org/wiki/Iris_flower_data_set)

sepal length 7.7	
sepal width 	3.8	
petal length 6.7	
petal width 2.2	

iOS app Suggest flower name :I. virginica using Machine learning Model. 

# About Core ML
Machine Learning in iOS Using Core ML

Core ML is an Apple framework which allows developers to simply and easily integrate machine learning (ML) models into apps running on Apple devices (including iOS, watchOS, macOS, and tvOS).  This can be used in variety of domains like object detection, sentiments analysis, hand writing recognization, music tagging etc. All this can be integrated with only one single file called Core ML Model and couple lines of code.
CoreML Model is the conversion of trained model to an Apple formatted model file (.mlmodel) that can be added to our project.
A Trained Model is the result of applying a machine learning algorithm to a set of training data. The model makes predictions based on new input data. For example, a model that's been trained on a region's historical house prices may be able to predict a house's price when given the number of bedrooms and bathrooms.
Core ML itself builds on top of low-level primitives like Accelerate and BNNS, as well as Metal Performance Shaders.

Core ML is optimized for on-device performance, which minimizes memory footprint and power consumption. Running strictly on the device ensures the privacy of user data and guarantees that your app remains functional and responsive when a network connection is unavailable.

# About Models:
If your model is created and trained using a supported third-party machine learning tool, you can use Core ML Tools to convert it to the Core ML model format. 
Supported models and third-party tools.

coremltools is a Python package. It contains converters from some popular machine learning libraries to the Apple format. In particular, it can be used to:
 Currently CoreML is compatible (partially) with the following machine learning packages:Caffe Keras libSVM scikit-learn XGBoost
Express models in .mlmodel format through a simple API.
Make predictions with an .mlmodel (on select platforms for testing purposes).

# CoreMLTool Installation
The method for installing coremltools follows the standard python package installation steps. Once you have set up a python environment, run following command in terminal : 

$ virtualenv -p /usr/bin/python2.7 env
$ source env/bin/activate
$ pip install tensorflow
$ pip install keras==1.2.2
$ pip install coremltools

Alternatively, Write a Custom Conversion Tool

It's possible to create your own conversion tool when you need to convert a model except Caffe Keras libSVM scikit-learn XGBoost.
Writing your own conversion tool involves translating the representation of your model's input, output, and architecture into the Core ML model format. You do this by defining each layer of the model's architecture and its connectivity with other layers. Use the conversion tools provided by Core ML Tools as examples; they demonstrate how various model types created from third-party tools are converted to the Core ML model format.

#  Convert Your trained model to coreML model.
Convert your model using the Core ML converter that corresponds to your model’s third-party tool. Call the converter’s convert method and save the resulting model to the Core ML model format (.mlmodel).

For example, if your model was created using Caffe, pass the Caffe model (.caffemodel) to the coremltools.converters.caffe.convert method.

import coremltools

coreml_model = coremltools.converters.caffe.convert('my_caffe_model.caffemodel')

Now save the resulting model in the Core ML model format.

coreml_model.save('my_model.mlmodel')

Run python NAME_OF_FILE.py to generate the (.mlmodel) file that we can directly use into our xcode project.

Clean up by deactivating the virtualenv:
$ deactivate

Here is an example making predictions using the trained iris_lr model which is python file created in scikit-learn package, that we converted in the iris_lr.mlmodel with the help of coreML tool:

# Load the model
model =  coremltools.models.MLModel(‘iris_lr.mlmodel’)

# Make predictions
predictions = model.prediction(sepal_length: a,sepal_width: b,petal_length: c,petal_width: d)

To create sample project follow the link below
https://www.bignerdranch.com/blog/machine-learning-in-ios-using-core-ml/

# Refrences--
https://pythonhosted.org/coremltools/index.html
https://developer.apple.com/documentation/coreml/converting_trained_models_to_core_ml
https://pypi.python.org/pypi/coremltools
https://alexsosn.github.io/ml/2015/11/05/iOS-ML.html

