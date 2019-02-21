
pacman::p_load(neuralnet, dplyr, ggplot2, MLmetrics, corrplot)
# let's start with a simple linear model just like we thought about earlier - housing price 

ds = read.table("http://www.rossmanchance.com/iscam2/data/housing.txt", header = T, sep = "\t")
head(ds)

set.seed(123)
# normally you'd want to do a more thorough exploratory data analysis 
ggplot(data = ds) + geom_point(aes(x=sqft, y=price, color=bedrooms)) 
ggplot(data = ds) + geom_point(aes(x=sqft, y=price, color=baths)) 


cor(ds$price, ds$sqft)
ds.cor = cor(ds %>% select(-City))
corrplot(ds.cor, type = 'upper', diag = T, addCoef.col = "white")


# normalize the data - helps the neural nets backpropegation algorithm to converge 

standardize = function(x) { (x - mean(x)) / sd(x) } 

index = sample(1:nrow(ds),round(0.75*nrow(ds)))
train = ds[index, ] %>% mutate_at(c('sqft', 'price', 'bedrooms', 'baths'), standardize)
test = ds[-index, ] %>% mutate_at(c('sqft', 'price', 'bedrooms', 'baths'), standardize)

m1 = lm(price ~ sqft + bedrooms + baths, data = train)
summary(m1)

m1.predict = predict(m1,test)
MAPE.m1 = MAPE(m1.predict, test$price)

m2 = neuralnet(price ~ sqft + bedrooms + baths, data = train, linear.output = T, hidden = 0)
predict(m2, test)

print(m2)
plot(m2) 
round(coef(m1), 3)

# Note that the parameters / weights on the linear regression model and the neural net are the same 

# starting with these super simple models, let's do some: 
# feature engineering & model selection using leave-one-out cross validation (LOOCV)
# then we can evaluate overall accuracy on the final model 
# then we can build 'deeper' neural nets with hidden layers, and see if the accuracy improves 
# note that this is a very small dataset just for illustrative purposes - often the neural net benefit is bigger for larger datasets

f1 = formula(price ~ sqft + bedrooms + baths)
N = dim(train)[1]

rladies.cv = function(f, N) {
  MAPE.m1 = MAPE.m2 = c()
  for(i in 1:N) { 
    data_cv_train = train[-i, ]
    data_cv_valid = train[i, ]  
    
    m1 = lm(f, data = train)
    m1.predict = predict(m1, data_cv_valid)
    MAPE.m1[i] = MAPE(m1.predict, data_cv_valid$price)
    
    m2 = neuralnet(f, data = train, linear.output = T, hidden = 0)
    m2.predict = predict(m2, data_cv_valid)
    MAPE.m2[i] = MAPE(m2.predict, data_cv_valid$price)
  } 
  return(data.frame(m1 = mean(MAPE.m1), m2 = mean(MAPE.m2)))
}

r1 = rladies.cv(f1, N) ; r1

# feature engineering / model selection using cross validation (LOOCV)

# we have that city variable - the data are too sparse to keep all 48 cities, but we can add an indicator for the most expensive cities
# note that for this kind of feature curating, we should check for unobserved cities in the test data! 

geo = ds %>% group_by(City) %>% summarize(mean_price = mean(price)) %>% arrange(desc(mean_price))
top_5 = geo %>% top_n(5, mean_price) %>% .$City 

ds = ds %>% mutate(top_5 = ifelse(City %in% top_5, 1, 0))

train = ds[index, ] %>% mutate_at(c('sqft', 'price', 'bedrooms', 'baths'), standardize)
test = ds[-index, ] %>% mutate_at(c('sqft', 'price', 'bedrooms', 'baths'), standardize)


fA = formula(price ~ sqft)
fB = formula(price ~ sqft + bedrooms)
fC = formula(price ~ sqft + baths)
fD = formula(price ~ sqft + top_5)
fD = formula(price ~ sqft + baths + bedrooms)
fE = formula(price ~ sqft + baths + bedrooms + top_5)

rladies.cv(fA, N) 
rladies.cv(fB, N) 
rladies.cv(fC, N) 
rladies.cv(fD, N) 
rladies.cv(fE, N) 


# now let's look at having more hidden neurons 

fE = formula(price ~ sqft + baths + bedrooms + top_5)
m = neuralnet(fE, data = train, linear.output = T, hidden = 2)
plot(m)

# we will need a cross validation function for (can leave out the linear regression now)

rladies.cv.nn = function(f, N_observations, N_hidden) {
  MAPE.nn = c()
  for(i in 1:N_observations) { 
    data_cv_train = train[-i, ]
    data_cv_valid = train[i, ]  
    
    m2 = neuralnet(f, data = train, linear.output = T, hidden = N_hidden)
    m2.predict = predict(m2, data_cv_valid)
    MAPE.nn[i] = MAPE(m2.predict, data_cv_valid$price)
  } 
  return(mean(MAPE.nn))
}

rladies.cv.nn(f = fE, N_observations = N, N_hidden = 1)

# now do we decide how many hidden neurons to include? We could let the data decide by exploring the accuracy across different values and 
# looking for some convergence (here I put 3, but many more would be needed - but it takes a while to run if you increase)
# It's easy to see how the computational burden of prediction increases rapidly - big datasets, complex models that take a long time to run each time, and lots of parameters to optimize
# There are many strategies to approach this, beyond the scope of today 

N_hidden_range = as.list(1:3)
results = lapply(X = N_hidden_range, FUN = rladies.cv.nn, f = fE, N_observations = N)

# not very meaningful across 3 values but you can imagine plotting 100 values, and seeing that more
# neurons decreases the MAPE, but that the benefit levels out after a certain point - that would help you select a good value for N_hidden

ggplot(data = data.frame(N_hidden_range = unlist(N_hidden_range), MAPE = unlist(results))) + 
  geom_line(aes(x = N_hidden_range, y = MAPE))

# We could also have more layers as well as more neurons per layer - getting even more computationally intense
# And now we have two parameters to optimize simultaneously...

m = neuralnet(f = fE, data = train, linear.output = T, hidden = c(2,1))
plot(m)


rladies.cv.nn(f = fE, N_observations = N, N_hidden = c(2,1))

# with such a tiny dataset, it's not practical to have too many nodes or layers

# Having a lot of layers is what makes a neural net 'deep' 
# It leads to a lot of interesting challenges (mostly computational) that Rladies could cover in another session 







