
#%% THE LANGUAGE

    # Syntax
#this is a comment, '#' marks the entire line as a comment (will not be ran)
a = 2 + 3 #Assign a variable to a value using '=' 
name = 'Jane Doe'
b = 76
print('Hello World')
print('Hello World'*2)
print('Her name is '+name)
print('The variable a equals {} and b is {}'.format(a, b))
a #you can also just call a variable to print its value

    # Data Types
integer = 9
decimal = 10.023
compl = 4+2j
boolean = True
string = 'Words'
string2 = 'Or even sentences!'
also_string = str(234)
int(decimal) #careful, as data may be lost by doing this
bool(-17) #false only for 0

  
    # Data Operations
c = 2+2
d = 198-2320
e = 2*17
f = 2**3
g = 620/13

f>b
a-1 == c
d < 200
e != b
'Doe' in name
e%17 #remainder/ function 

(f>b) or (d < 200)
(e >= b) & ('r' in string2)
string[2:3]
string2[:-5]
print(sting2.count('s')) #Counts the number of times 's' appears in the string
print(message.find(n)) #Finds the index of the first 'n' it finds in the string

    # Data Structures
#Lists (can make changes, ie mutable)
my_list = ['Jane', 'Montreal', 35, 179.5]

print(my_list[0]) #Elements can be accesed through indexing
print(my_list[0:3])
print(len(my_list))
print('J' in my_list)
print('Montreal' in my_list)
print(sum(my_list[2:]))

my_list.append('Blonde')
my_list[2] = 36

list1 = [1,2,3]
list2 = [4,5,6]
list3 = list1 + list2 #Concatenate lists with the + sign.
print(list3)

#Tuples (cannot make changes, ie immutable)
fruits = ('apple', 'orange', 'banana', 'mango')
len(fruits)
fruits[:] #from start to end
fruits[-2]
fruits[-2] = 'strawberry'

#Sets (not ordered, each element appears once; only allows immutable objects (number, string, tuple))
      #but is itself mutable (.add, .remove attributes)
my_set = {12, 'car', (2,3)}
13 in my_set
my_set.add(3.14)
len(my_set)

#Dictionanries (stores keys and values, ordered and mutable)

fruits_available = {"kiwi": 7, "oranges": 12, "bananas": 120, "mango": 0}
fruits_nutrition = {"kiwi": {"calories" : 74, "water_percent" : 86, "fibre_grams" : 3.4}, 
                    "orange" : {"calories" : 60, "water_percent" : 86, "fibre_grams" : 3.0},
                    "mango" : {"calories" : 160, "water_percent" : 76, "fibre_grams" : 5.4}}
fruits_available['oranges']
fruits_nutrition['mango']['calories']
fruits_available.keys()
fruits_nutrition['kiwi'].values()

fruits_nutrition['banana'] = {"calories" : 40, "water_percent" : 22, "fibre_grams" : 7.4}
    #no need to index as dictionnaries are unordered
    # Control Structures
#If/Else If/Else
if fruits_available['mango']>0: 
  print('There are mangoes in stock')
else: print('There are no more mangoes')

if fruits_nutrition['kiwi']['calories'] > fruits_nutrition['orange']['calories']:
  print('Kiwi has more calories than orange')
elif fruits_nutrition['kiwi']['calories'] < fruits_nutrition['orange']['calories']:
  print('Kiwi has less calories than orange')

if fruits_nutrition['banana']['water_percent'] < 50:
  print('banana is not water rich')
if fruits_nutrition['banana']['water_percent'] > 50:
  print('banana water rich')
  
#For loops
for x in fruits_available.keys():
  print(x)

for x,y in fruits_nutrition.items():
  print(x, y)
  if y['fibre_grams'] > 3:
    print(x+' is fibre rich')
    
for x in fruits_available.keys():
  if len(x) > 6:
    continue #skips the rest of the forloop and goes to the next iteration
  print(x)

for x in fruits_available.keys():
  if len(x) > 6:
    break #terminates the for loop
  print(x)
#While loops

x=0 #initialize a counter for while loops
while x < len(my_list):
    print(my_list[x])
    x += 1
  #careful with never ending while loops!
  
#List Comprehension 

comp_list = [x for x in range(1,100) if x%7 == 0]
comp_list

#%% Try-it...

  #Q1 - Write a program to count the total number of digits in a number
given_number = 545098

given_number = str(given_number)
count=0
for i in given_number:
        count += 1
print(count)

  #Q2 - Write a program to find the factorial of a given number
given_number= 12

factorial = 1
for i in range(1, given_number + 1):
    factorial = factorial * i
print('The factorial of ', given_number, ' is ', factorial)

  #Q3 - Write a program to give the number of days in a given month, your program should
        #give an error message if a month isn't inputed

given_months = ["January", "April", "August","June","Monday"]
 
for i in given_months:
    if i == "February":
            print("The month of February has 28/29 days")
    elif i in ("April", "June", "September", "November"):
            print("The month of",i,"has 30 days.")
    elif i in ("January", "March", "May", "July", "August", "October", "December"):
            print("The month of",i,"has 31 days.")
    else:
            print(i,"is not a valid month name.")
 
#%% FUNCTIONS

def function_name(var1, var2, var3):
  #it is good coding practice to add a comment on the function's function and the variables
  var4 = var1+var2+var3
  return var4

  #Q4 Write a function which tells you if number a is divisible by number b.
      #if its not, give the remainder
      #Your function should call out wrong inputs
  
def is_divisible(a, b):
  #checks if a is divisible by b
  if (type(a) not in [int, float]) or (type(b) not in [int, float]):
    print('Invalid input')
    return
  if a%b == 0:
    print('{} is divisible by {}'.format(a, b))
  else: print('{} is not divisible by {}, and the remainder is {}'.format(a, b, a%b))
    
#%% PACKAGES
#You don't always want to write functions from scratch, 
#MANY MANY functions were previously written and are available through packages
import math # More math functions, https://docs.python.org/3/library/math.html
math.pi
math.factorial (12)

import numpy as np #multidimensional arrays, https://numpy.org/ 
rand_arr = np.random.rand(2,2)
zero_arr = np.zeros((3,2))
list2_to_arr = np.asarray(list2)
list_to_arr = np.asarray([list2,list1])

import pandas as pd #for labeled tables, https://pandas.pydata.org/ 
cols = ['Name', 'Age', 'Town', 'Height']
data = [ ['Jane', '35', 'Montreal', '178.5cm'],
        ['John', '12', 'Toronto', '148.5cm'],
        ['Severus', '55', 'Oxford', '198.5cm'],
        ['Bob', '75', 'Ohio', '155.0cm']]
df = pd.DataFrame(data, columns = cols)
df['Name'] #Outputs the columnt name
df.iloc[3] #outputs the row indexed 3 (fourth row)
df['Town'][2]

from sklearn.datasets import load_iris #sklearn for machine learning, iris dataset for examples
df = load_iris(as_frame=True)
df_iris = df.data

import matplotlib.pyplot as plt

x_vals = [i for i in range(10)]
y_vals = np.random.rand(10)
 fig, ax = plt.subplots()

    ax.scatter(
        x = x_vals 
        y = y_vals, 
        s = 5,
        label = 'Example 1',
        color = 'blue',
        )
    
    ax.scatter(
        x = x_vals, 
        y = y_vals*2, 
        s = 10,
        label = 'Example 2',
        color = 'red',
        )
    
    ax.legend()
    ax.set_title('Python in R')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_ylim([0, 10])
    ax.set_xlim([0, 10])
    ax.yaxis.grid(True)
    ax.xaxis.grid(True)
    
    plt.show()
import seaborn as sns
import plotly




  
