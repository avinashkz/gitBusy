# gitBusy <img src="man/figures/logo.png" align="right"/>


[![Build Status](https://travis-ci.org/avinashkz/gitBusy.svg?branch=master)](https://travis-ci.org/avinashkz/gitBusy)

**gitBusy** is a user-friendly and intuitive API wrapper for Github. The package allows users to efficiently retrieve information on organizations, users, and repositories from the Github website.

This project is part of the DSCI 525 Web and Cloud Computing Course for the Masters of Data Science program at The University of British Columbia.

## Functions

* `organization_members(organization)`
  * Returns a list of all the public users with their most commonly used languages in a dataframe and as a ggplot item.

* `org_repos(organization)`
  * Function returns the the name, link and language for all the repositories in the organization.

* `repo_count(user)`
  * Return the number of Pulic Repositories for an ID

* `user_preferences(user)`
  * The function reads in the ID of a user and returns the a dataframe and ggplot item of the languages used by the user.


## Installation / Uninstallation and Execution

To install this package, run the following command in the console for RStudio:

`devtools::install_github("UBC-MDS/gitBusy")`

Installing the package automatically installs the vignette.

To perform a clean removal of the packages, run

`remove.packages('gitBusy')`

## Running Tests
To run the tests for this package, download and change directory to the repository.
Then, in _Rstudio_ console:

1. Load the package functions into the environment using `devtools::load_all()`
2. Run the tests using: `devtools::test()`

## Authors:

Abishek Murali @abimur-123

Sid Arora @sarora

Ivan Despot @Ivan-Despot

Avinash Prabhakaran @avinashkz
