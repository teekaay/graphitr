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
