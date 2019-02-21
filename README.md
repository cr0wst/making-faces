## Facial Recognition Example
This example requires that you have the `imager` package installed via `install.packages("imager")`.

To run the face example you will need to supply your own training and test set. Put these images in the training_set and test_set folder.

For training and test set images, I recommend the Yale Face Database: http://vision.ucsd.edu/content/yale-face-database

## How to use with Yale Faces

This repo does not contain the images used in the slides. I recommend the Yal Face Database.

### Clone the Repository

```sh
git clone https://github.com/cr0wst/making-faces.git
```

### Download Yale Face Database

You can download the Yale Face Database here: http://vision.ucsd.edu/content/yale-face-database

### Extract Images Into `training_set`

The Yale Face Database contains 165 GIF images of 15 subjects. The images do not have the gif extention.

For example, I'm going to select 5 subjects (The first 5) to build my training set. I will grab them in their sad, happy, sleepy, and surprised states. Copy them to the training set folder, and give them the gif extension.

From the `making-faces` folder:
```sh
unzip yalefaces.zip
find yalefaces/ -type f -exec basename {} \;| grep -Ei "subject0[1-5]\.(sad|happy|sleepy|surprised)" | xargs -I F cp yalefaces/F training_set/"F".gif
```

### Extract Images Into `test_set`

Now, I'll grab 3 images and put them in `test_set`. For demonstration I'm going to grab the sad image of Subject01, the wink image from Subject03, and the happy image of Subject06.

This demonstrates an image that's already in the training set, a person in the training set, and a person not in the training set:

```sh
cp yalefaces/subject01.sad test_set/subject01.sad.gif
cp yalefaces/subject03.wink test_set/subject03.wink.gif
cp yalefaces/subject06.happy test_set/subject06.happy.gif
```

### Run the Face Example.R Script

Finally, run the Face Example.R script:

```sh
Rscript -e "source('Face Example.R', chdir=TRUE)"
```

Note: I'm using `source` here so that the working directory is set to the current directory.

### Results

```
[[1]]
              test.file.name min.index min.dist                  min.file.name max.index max.dist                    max.file.name
1 test_set/subject01.sad.gif         2        0 training_set/subject01.sad.gif         9 2046.016 training_set/subject03.happy.gif

[[2]]
               test.file.name min.index min.dist                     min.file.name max.index max.dist                    max.file.name
1 test_set/subject03.wink.gif        11 75.02115 training_set/subject03.sleepy.gif         5 3481.817 training_set/subject02.happy.gif

[[3]]
                test.file.name min.index min.dist                        min.file.name max.index max.dist                    max.file.name
1 test_set/subject06.happy.gif        12 744.4977 training_set/subject03.surprised.gif         5 3064.192 training_set/subject02.happy.gif
```
