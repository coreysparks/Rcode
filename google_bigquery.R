library(bigrquery)
projectid = "csparksdatascie"

# Set your query
sql <- "SELECT * FROM `bigquery-public-data.chicago_crime.crime` LIMIT 10"

# Run the query and store the data in a tibble
tb <- bq_project_query(projectid, sql)

# Print 10 rows of the data
bq_table_download(tb, n_max = 10)
