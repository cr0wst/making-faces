library("plot3D")
library("plotrix")

########################
## Creating the Model ##
########################
# Step 1 Create Training Set
songs = read.csv('songdata.csv')[c('energy', 'loudness')]
training_set = t(data.matrix(songs))

# Step 2 Perform Mean Normalization
centered = training_set - rowMeans(training_set)

# Step 3 Perform SVD
svd = svd(centered / sqrt(ncol(training_set)))

# Step 4 Project the Training Set
training_projections = svd$u %*% diag(svd$d) %*% centered


#######################
## Testing the Model ##
#######################
# Step 1 Create the Test Set (Single Song in this Example)
test_song = c(-2, 2) - rowMeans(training_set)

# Step 2 Create Test Projections
test_projections = svd$u %*% diag(svd$d) %*% test_song

# Build Result Data (Here we are using a single dimension so grab first element)
distances = abs(test_projections[1,] - training_projections[1,])
dist = data.frame(
  "min.dist" = min(distances), 
  "min.index" = which(distances == min(distances))
  )

print(dist)