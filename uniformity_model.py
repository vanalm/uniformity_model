#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jan  7 15:07:39 2023

@author: jacobvanalmelo
originally written in matlab, translated by openai davinci to python on 1/7
"""
import sympy as sp
import matplotlib.pyplot as plt
from scipy.integrate import quad
import numpy as np

# initiate symbolic variable
t = sp.symbols('t')

#R^2= 0.9745  | based on priva Transpiration Data of Conv Maravilla start 12, 10.31.2016
trans = ((0.4069*t**4)-(21.061*t**3)+(383.29*t**2)-(2866*t)+7527.4) 

#getting user input
phase1 = float(input("Enter phase volume (ml): "))
limit = float(input("Enter lower volume limit (ml): "))
starting_moisture = float(input("Enter Starting moisture (ml): "))
n = int(input("Enter number of plants: "))
numROplants = int(input("Enter number of plants on Root Optimizer: "))
sigma = float(input("Enter Sigma value of distribution: "))
numdays = int(input("Enter number of days to model: "))

#creating an array with random factors for each plant
unifactors = np.random.normal(1,sigma, n)

#creating an array and setting each plant's starting moisture
field = np.ones(n)*starting_moisture

#plotting the initial field
plt.bar(field)
plt.ylim(0, 7000)

#creating an array to represent each different plant's transpiration rate
crop = unifactors @ trans

#creating a vector to update the bar graph
Bar1 = np.zeros(len(field))

#iterating through days
for i in range(numdays):
    print('SUNRISE')
    for t in np.arange(8, 18.5, 0.25):
        #calculating the transpiration rate over the given time interval
        consumption, err = quad(lambda x: crop.subs(t, x), t-0.25, t)
        print('TRANSPIRATION')
        #updating the moisture level of each plant
        field = field - consumption
        #updating the bar graph
        Bar1 = np.vstack((Bar1,field))
        plt.cla()
        plt.bar(Bar1)
        plt.ylim(0, 7000)
        plt.draw()
        plt.pause(0.1)

        #checking the moisture level of the plants on the root optimizer
        ROplants = field[:numROplants]
        if np.sum(ROplants) <= limit*numROplants:
            #adding irrigation if the moisture level is below the limit
            field = field + phase1
            print('IRRIGATION')
            #updating the bar graph
            Bar1 = np.vstack((Bar1,field))
            plt.cla()
            plt.bar(Bar1)
            plt.ylim(0, 7000)
            plt.draw()
    print('SUNSET')