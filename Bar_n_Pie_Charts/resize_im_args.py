# -*- coding: utf-8 -*-
"""
Created on Wed Nov  2 11:36:22 2016

@author: shravankumar
"""

# -*- coding: utf-8 -*-
"""
Created on Wed Nov  2 11:07:46 2016

@author: shravankumar
"""
from imutils import paths
import argparse
import cv2


def imresize(image, size=(512, 512)):
        # resize the image to a fixed size, then flatten the image into
        # a list of raw pixel intensities
        return cv2.resize(image, size)

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=True,
        help="path to input dataset")
args = vars(ap.parse_args())

# grab the list of images that we'll be describing
print("[INFO] describing images...")
imagePaths = list(paths.list_images(args["dataset"]))
#imagePaths = glob.glob("barfigs/*.png")
# initialize the data matrix and labels list
data = []

# loop over the input images
for (i, imagePath) in enumerate(imagePaths):
        # load the image and extract the class label (assuming that our
        # path as the format: /path/to/dataset/{class}.{image_num}.jpg
        print("[INFO] Read the image:\n {}{}".format(i,imagePath))
        image = cv2.imread(imagePath)
        # construct a feature vector raw pixel intensities, then update
        # the data matrix and labels list
        imgrsz = imresize(image)
        cv2.imwrite(imagePath,imgrsz)
        print("[INFO] Resized and Write into:\n {}{}".format(i,imagePath))
        print("[][][][][][][][][][][][][][][][][][][]")

print("[INFO] DONE")

        