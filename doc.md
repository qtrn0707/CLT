---
title: "Documentation for Central Limit Theorem Demonstration"
author: "qtrn0707"
date: "August 20, 2017"
output: html_document
---



## Description

The **Central Limit Theorem Demonstration** app is intended to demonstrate the central limit theorem, one of the most important theorems in all of statistics. It states that given a random sample of size *n* - that is, a sequence of independent and identically distributed random variables drawn from distributions of expected values given by $\mu$ and finite variances given by $\sigma^2$, as $n \rightarrow \infty$, the distribution of the sample mean converges to a normal distribution with mean $\mu$ and variance $\frac{\sigma^2}{n}$.


## Usage

The user should first select a distribution. The following distributions are available:

- Beta

- Binomial

- Chi-Square

- Exponential

- Geometric

- Log Normal

- Normal

- Poisson

- Uniform

After selecting the distribution, the appropriate parameter selectors will appear, and the user can change the corresponding parameters of the chosen distribution.

There are sliders that allow the user to choose the number of random observations in a sample and the number of samples.

The user can also choose whether to display the density of a normal distribution with mean and standard deviation equal to their empirical counterparts, as well as a generic kernel density.


## Output

The output consists of two plots.

The first one is the histogram of the generated sample means. The normal density (if present) is colored <span style="color:red">red</span>. The kernel density (if present) is colored <span style="color:blue">blue</span>.

The second plot is a Q-Q Plot with two distributions:

1. The theoretical normal distribution with parameters equal to their sample counterparts.

2. The empircal distribution of the generated sample means.

A <span style="color:pink">pink</span> line is also drawn, representing the theoretically correct quantile plot.
