#LIBRERIAS R
library(R.matlab)
library(rms)
library(ggplot2)
library(QuantPsyc)

#SETPATH - DIRECTORIO DONDE TENGO EL SCRIPT Y DONDE VOY A GUARDAR ??
setwd("/Users/maximo/Downloads/r")

#ADD CUSTOM FUNCTIONS
source('Statistical_auxiliary_functions.R')

#levantar un o dos .mat para crear un data frame, adem?s las variables de guardado de los plots

#PARAMETERS
table_filename = 'P9_RegTable.mat'  #filename of .mat with a variable named 'table'
label_filename = 'P9_RegTable_labels.mat' #filename of .mat with a variable named 'labels', which corresponds to the columns of table

binary_column_name = 'Stymulus.Type'
binary_column = 5
initial_column_data = 10

alpha <- 0.05
path_to_save = 'testprint\\';

save <- 1

#PARAMETERS - NOT INPUTS
# choose a threshold for dichotomizing according to predicted probability
threshold  <- 0.5

#LOAD DATA
table_data <- data.frame(readMat(table_filename)$table)
labels_data <-sapply(readMat(label_filename)$labels,function(n) n[[1]])
names(table_data) <-make.names(c(labels_data))

#DATA TO ANALYSE - VER SI PUEDO HACER QUE LAS VARIABLES SEAN INPUTS
binary_column = as.numeric(unlist(table_data[binary_column_name])) #VARIABLE DICOTOMICA = Stimulus Type
ylabel = which( colnames(table_data)== binary_column_name) #nro de columna de la variable dicotomica

#CALCULO DE LAS REGRESIONES LOGISTICAS
data_no_outliers <- data.frame(matrix(ncol = dim(table_data)[2], nrow = dim(table_data)[1]))
names(data_no_outliers) <-make.names(c(labels_data))

for (i in initial_column_data:dim(table_data)[2] ) {
  column_data <- c(table_data[,i])
  column_data_no_outliers <- outlier_determination(column_data)  
  data_no_outliers[,i] = column_data_no_outliers
  
  glm.out = glm( binary_column ~ column_data_no_outliers, family=binomial(logit))
  #glm.out = glm( binary_column ~ xData, family=binomial)
  okay <- !is.na(column_data_no_outliers) 
  x = column_data_no_outliers[okay]
  y = binary_column[okay]
  mod1b <- lrm(y ~ x)
  #summary(glm.out) -> output table?
  p_value <- summary(glm.out)$coef[2, 4]
  R2<-mod1b$stats["R2"]

  if(p_value <= alpha)
  {    
    print(paste(i,labels_data[i],'   ' , R2,'   ' , p_value))

    odds<-ClassLog(MOD = glm.out, y,cut=0.5)
    percent_correct <- odds$overall*100
    Yhat <- fitted(glm.out)
    YhatFac <- cut(Yhat, breaks=c(-Inf, threshold, Inf),labels=c("0", "1"))
    
    # contingency table and marginal sums
    cTab <- table(y, YhatFac)
        
    # percentage correct for training data
    percent_correct2 <- sum(diag(cTab)) / sum(cTab)*100
    sTitle  = paste(' p = ',round(p_value,8),' , R2 = ', round(R2,4), ', %P.Corr1 = ', round(percent_correct,4), ', %P.Corr2 = ', round(percent_correct2,4))

    #plot
    xlabel = labels_data[i];
    filename_to_save = paste(path_to_save,xlabel,'.png')
    plot_logistic_regression(x,y,sTitle,xlabel,ylabel,glm.out,filename_to_save,save)
  }
}

