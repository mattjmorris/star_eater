# Function to group locations based on euclidean distances.
# Example Usage:
#   grouped_elements = group(matrix_or_table, number_groups_desired)
# Returns:
#   [
#     [1.0, 45.0, 100.0, 1.0], [2.0, 40.0, 100.0, 1.0], [3.0, 45.0, -100.0, 2.0], [4.0, 40.0, -100.0, 2.0], 
#     [5.0, -45.0, -100.0, 4.0], [6.0, -40.0, -100.0, 4.0], [7.0, -45.0, 100.0, 3.0], [8.0, -40.0, 100.0, 3.0] 
#   ]

group <- function(coord_array, num_groups)  {
	rowCount = length(coord_array)

	# Create initial matrix with correct dimensions, and set all values to 0
	matConvert = matrix(0, ncol=3, nrow=rowCount)
	for(i in 1:rowCount) {
	  #remove list structure, making it a vector. Insert values into matrix
	  matConvert[i,]=unlist(coord_array[i])
	}

  # mat_from_array = matrix(vects_data, ncol=3, nrow=8)
  dfLatLong = data.frame(matConvert)

  # Cluster analysis function is kmeans()
  clusters = kmeans(dfLatLong[,2:3], center=num_groups, nstart=5, algorithm = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"))

  #set up the structure to return. First R format, and then work towards array format for Ruby
  df_Grouping = data.frame(cbind(dfLatLong, clusters$cluster)) 

  #convert to matrix, and then array
  matNew = data.matrix(df_Grouping)
  array_Return = array(matNew, dim=c(rowCount,4))
}
