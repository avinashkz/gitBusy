% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gh_auth.R
\name{gh_auth}
\alias{gh_auth}
\title{Function to authenticate with GitHub}
\usage{
gh_auth(key, secret)
}
\arguments{
\item{key}{Client ID from GitHub}

\item{secret}{Client secret from GitHub}
}
\value{
Authentication token
}
\description{
The function uses the Secret ID and Secret Key generated from GitHub to
authenticate user.
}
\examples{
gh_auth(key="xx", secret="yyy")

}
