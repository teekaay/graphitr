
#' Get raw metrics from Graphite.
#'
#' @param host The address of the Graphite server
#' @param from Start of the time series. You can use either a Date or a string
#' @param until End of the time series. You can either use a Data or a string
#' @param target The metric to retrieve
#' @param format The format of the data. Defaults to csv
graphite_get <- function(host, from, until, target, format = 'csv') {

}