library(stringr)

kGraphiteRenderEndpoint <- 'render?'
kGraphiteCsvHeader <- c('target', 'timestamp', 'value')
kGraphiteCsvSep <- ','

#' Get raw metrics from Graphite.
#'
#' @param host The address of the Graphite server
#' @param from Start of the time series. You can use either a Date or a string
#' @param until End of the time series. You can either use a Data or a string
#' @param target The metric to retrieve
#' @param format The format of the data. Defaults to csv
#' @return A data frame
graphite_get <- function(host, from, until, target, format = 'csv') {
  host_f <- format_host_name(host)
  uri <- graphite_render_uri(host_f, from, until, target, format = format)
  return(graphite_read_csv(uri))
}

#' Read a file from the file system that was downloaded from Graphite.
#'
#' @param path The path of the file
#' @return A data frame
graphite_get_local <- function(path) {
  uri <- format_host_name(path, default_scheme = 'file')
  return(graphite_read_csv(uri))
}

#' Read a CSV file in Graphite format as a data.frame.
#'
#' This function is a wrapper around read.csv with additional
#' naming of the columns.
#'
#' @param path The path of the resource
#' @return A data frame
graphite_read_csv <- function(path) {
  df <- read.csv(path, header = FALSE, sep = kGraphiteCsvSep, stringsAsFactors = FALSE)
  names(df) <- kGraphiteCsvHeader
  return(df)
}

#' Render the graphite URL from multiple parameters.
#' The URL is rendered in the following format:
#' <host>/render?from=<from>&until=<until>&target=<target>&format=<format>.
#'
#' @param host The address of the graphite server
#' @param from Start of the time series
#' @param until End of the time series
#' @param format The output format
#' @return The rendered URI
graphite_render_uri <- function(host, from, until, target, format = 'csv') {
  key_value_param <- function(key, value) {
    kv <- paste(key, value, sep = '=', collapse = '')
    return(kv)
  }
  q_from <- key_value_param('from', from)
  q_until <- key_value_param('until', until)
  q_target <- key_value_param('target', target)
  q_format <- key_value_param('format', format)
  url_query_params <- paste(q_from, q_until, q_target, q_format, sep = '&', collapse = '')
  url <- paste(host, kGraphiteRenderEndpoint, url_query_params, sep = '', collapse = '')
  return(url)
}

#' Formats a hostname to be valid.
#' The pattern for an URI is <scheme>://<host>{/}.
#' where scheme should be one of 'http' or 'file'. If the scheme is
#' 'file' then no trailing slash is appended
#'
#' @param host The hostname (can also be a local path to a file or anything that read.csv supports)
#' @param default_scheme The scheme to append if no scheme is found
#' @return The formatted host string
format_host_name <- function(host, default_scheme = 'http') {
  if (str_length(host) == 0) {
    return(host)
  }
  uri_scheme <- stringr::str_extract(host, '(http|file)://')
  if (is.na(uri_scheme)) {
    host <- str_c(default_scheme, '://', host)
  }
  last_char <- substr(host, str_length(host), str_length(host))
  if (last_char != '/' && default_scheme != 'file') {
    host <- str_c(host, '/')
  }
  return(host)
}

#' Format the path as a file URI by prepending file://.
#'
#' @param path The path of the resource
#' @return The formatted path
format_as_file_uri <- function(path) {
  return(format_host_name(path, default_scheme = 'file'))
}

#' Format the path as a HTTP URI by prepending http://
#'
#' @param path The path of the resource
#' @return  The formatted path
format_as_http_uri <- function(path) {
  return(format_host_name(path, default_scheme = 'http'))
}