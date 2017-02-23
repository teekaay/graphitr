library(testthat)

context('format_host_name')

test_that('http:// and trailing slash are added', {
  # given
  uri_without_scheme <- 'my-uri.org'
  expected <- 'http://my-uri.org/'
  # when
  formatted_uri <- format_host_name(uri_without_scheme, default_scheme = 'http')
  # then
  expect_equal(formatted_uri, expected)
})

test_that('no trailing slash is added if exists', {
  # given
  uri_with_trailing <- 'http://my-uri.org/'
  # when
  formatted_uri <- format_host_name(uri_with_trailing)
  # then
  expect_equal(formatted_uri, uri_with_trailing)
})

test_that('empty uris are not formatted', {
  # given
  empty_uri <- ''
  # when
  formatted_uri <- format_host_name(empty_uri)
  # then
  expect_equal(formatted_uri, '')
})