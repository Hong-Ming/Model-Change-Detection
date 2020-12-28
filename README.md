# Model Change Detection System

## Table of Contents
- [Intorduction](#intorduction)
- [Directory Tree](#directory-tree)
- [Requirements](#requirements)
- [Result](#result)
- [Contributor](#contributor)

## Intorduction
This is a demo for the model change detection system on a landmine dataset. The model change detection system utilized KL-divergence and machine learning algorithms to classify landmines data collected from different surface conditions. This demo is built during the independent study in UIUC.

## Directory Tree
<pre>
Model_Change_Detection/
├─ MCDdemo.m ............ Demo for model change detection system
├─ JSdemo.m ............. Function for ploting the demo result
├─ JSdivergence.m ....... Function for KL-divergence
├─ LandmineData.mat ..... Landmine dataset
└─ result.png ........... 
</pre>

## Requirements
- **MATLAB**: [2019a or later](https://www.mathworks.com/products/matlab.html)

## Result
**There are 29 data in Landmine Dataset, data 1/~15 were collected form surfaces with relatively high foliated and data 16~29 were colledted from regions that are bare earth or desert. The simulation result demonstrated that the model change detection system was able to detect the change in the underlying distrubution of the data.**
![demo result](https://github.com/Hong-Ming/Model_Change_Detection/blob/main/result.png)

## Contributor
- [Hong-Ming Chiu](https://hong-ming.github.io/)