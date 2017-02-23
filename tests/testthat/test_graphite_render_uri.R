library(testthat)

context('graphite_render_uri')

test_that('it renders a full URI', {
  # given
  host <- 'http://graphite.org/'
  from <- '-1d'
  until <- 'now'
  target <- 'my.target'
  format <- 'csv'
  expected <- 'http://graphite.org/render?from=-1d&until=now&target=my.target&format=csv'
  # when
  rendered_url <- graphite_render_uri(host, from = from, until = until, target = target, format = format)
  # then
  expect_equal(rendered_url, expected)
})