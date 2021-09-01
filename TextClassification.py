import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import svm
from sklearn.metrics import accuracy_score,classification_report,precision_score,recall_score,f1_score,confusion_matrix


class TextClassification:
    """Class contains functions to 
       1. Split data into training and test data using stratified sampling
       2. Train the model on training data 
       3. Test the model on testing data     
       
       Returns :
       1. Trained model
       2. Training accuracy
       3. Testing accuracy
       4. Classwise matrix
       """
    features_train = None
    features_test=None
    label_train=None
    label_test=None
    model = None
    vectorizer=None
    model_train_data_accuracy=None
    model_test_data_accuracy=None
    post_training_perf_matrix=None
    results= None
    model_name = None
    model_description = None
    model_id=None
    version_id=None
    response_register_model = None
    response_deploy_model = None
    
    def __init__(self, DF_DATA, label, text_column_name):
        self.DF_DATA = DF_DATA
        self.label = label
        self.text_column_name = text_column_name

        
    def SplitData(self):
        try:

            input_train,input_test,label_train,label_test = train_test_split(self.DF_DATA,self.DF_DATA[self.label],
                                                                             test_size=0.2,random_state = 42,
                                                                             stratify=self.DF_DATA[self.label]) 
            return input_train,input_test,label_train,label_test
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error in spliting the data into train and test dataset !!')    
            logging.error(e)    
            return -1        
    
    
    def train_model(self,vectorizer,train_x,train_y):
        try:
            train_vectorized_data = vectorizer.transform(train_x[self.text_column_name].to_list())
            model = svm.SVC(C=10e3,probability=True,decision_function_shape='ovo')
            model.fit(train_vectorized_data,train_y)
            result = model.predict(train_vectorized_data)
            model_train_data_accuracy = accuracy_score(result,train_y) * 100 
            return model,model_train_data_accuracy
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error occured while training the model !!' )    
            logging.error(e)    
            return -1  
    
    def test_model(self,vectorizer,model,test_x,test_y):
        try:
            test_vectorized_data = vectorizer.transform(test_x[self.text_column_name].to_list())
            result = model.predict(test_vectorized_data)
            model_test_data_accuracy = accuracy_score(result,test_y) * 100 
            return result,model_test_data_accuracy
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error occured while checking the performance of the model on test data. !!' )    
            logging.error(e)    
            return -1      
    
    def get_vectorizer(self):
        try:
            vectorizer = TfidfVectorizer(max_features=2000)
            vectorizer.fit(self.DF_DATA[self.text_column_name].to_list())
            return vectorizer
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error in fitting the Vectorizer  !!')    
            logging.error(e)    
            return -1   
        

    def get_performance_matrix_test_data(self,y_True,y_pred):
        try:
            df = pd.DataFrame(classification_report(y_True,y_pred,output_dict=True)).transpose()
            df.reset_index(inplace=True)
            df.rename(columns={"index":"classes"},inplace=True)
            df = df[:-3]
            cm = confusion_matrix(y_True, y_pred,labels=sorted(y_True.unique()))
            per_class_accuracies = {}
            for idx, cls in enumerate(sorted(y_True.unique())):
                true_negatives = np.sum(np.delete(np.delete(cm, idx, axis=0), idx, axis=1))
                true_positives = cm[idx, idx]
                per_class_accuracies[cls] = (true_positives + true_negatives) / np.sum(cm)
            accuracy = pd.DataFrame.from_dict(per_class_accuracies, orient='index', 
                                              columns=['accuracy']).reset_index().rename(columns={'index':'classes'})
            df = df.merge(accuracy,on='classes')
            df.rename(columns={"f1-score":"f1_score"},inplace=True)
            df.rename(columns={"classes":"category_name"},inplace=True)    
            return df        
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error in getting performance matrix of the model on test data !!')    
            logging.error(e)    
            return -1   
    
    def build_model(self):
        try:
            self.features_train,self.features_test,self.label_train,self.label_test = self.SplitData()
            self.vectorizer = self.get_vectorizer()
            self.model,self.model_train_data_accuracy = self.train_model(self.vectorizer,self.features_train,self.label_train)
            self.result,self.model_test_data_accuracy = self.test_model( self.vectorizer,self.model,self.features_test,self.label_test)
            self.post_training_perf_matrix = self.get_performance_matrix_test_data(self.label_test,self.result)
            return 
        
        except Exception as e:
            logging.basicConfig(filename=LogPath,level=logging.ERROR)
            logging.error('Error in building model : ' + self.model_name)    
            logging.error(e)    
            return -1           


