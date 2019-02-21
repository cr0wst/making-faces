library("imager")

########################
## Creating the Model ##
########################
# Step 1 Create Training Set
training_set_files = list.files(path = 'training_set', pattern = '.jpg', full.names = TRUE)
training_set_faces = map_il(training_set_files, load.image)
training_set = matrix(
  unlist(lapply(training_set_faces, function(x) x[, , , 1])),
  ncol = length(training_set_faces),
  byrow = FALSE)

# Step 2 Perform Mean Normalization
average_face = rowMeans(training_set)
centered = training_set - average_face

# Step 3 Perform SVD
svd = svd(centered / 5)

# Step 4 Project the Training Set Into Low-Rank Dimension
training_projections = t(svd$u %*% diag(svd$d)) %*% centered

#######################
## Testing the Model ##
#######################
# Step 1 Create Test Set
test_files = list.files(path = 'test_set', pattern = '.jpg', full.names = TRUE)
test_faces = map_il(test_files, load.image)
test_set = matrix(
  unlist(lapply(test_faces, function(x) x[, , , 1] - average_face)),
  ncol = 3,
  byrow = FALSE)

# Step 2 Create Test Set Projections
# Centered Data Into Matrix
test_set_projections = t(svd$u %*% diag(svd$d)) %*% test_set

# Build Result Data
distances = apply(test_set_projections, 2, function(test) {
  dist = apply(training_projections, 2, function(x) sqrt(sum((x - test) ^ 2)))
  data.frame(
    "min.index" = which(dist == min(dist)),
    "min.dist" = min(dist),
    "max.index" = which(dist == max(dist)),
    "max.dist" = max(dist)
  )
})

print(distances)