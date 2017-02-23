# graphitr

This package makes it easy to retrieve metrics from Graphite
servers by using it's render API for raw data.

# Usage

    library(graphitr)
    
    host <- 'http://graphite.org/'
    from <- '-1d'
    until <- 'now'
    metric <- 'servers.*.cpu_time'
    # renders http://graphite.org/render?from=-1d&until=now&target=servers.*.cpu_time&format=csv
    query_url <- graphite_render_uri(host, from, until, metric)
    # get the metrics as a data frame from Graphite
    graphite_df <- graphite_get(host, from, until, metric)
    # get the metrics from a CSV file
    graphite_df_local <- graphite_get_local('path/to/file.csv')

# Developing

* To install all dependencies, use `make deps`
* To run tests, use `make tests`
* To generate documentation, use `make docs`