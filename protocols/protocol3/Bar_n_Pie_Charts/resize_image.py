# -*- coding: utf-8 -*-
"""
Created on Wed Nov  2 11:07:46 2016

@author: shravankumar
"""

import numpy as np
import cv2
import glob


def imresize(image, size=(512, 512)):
        # resize the image to a fixed size, then flatten the image into
        # a list of raw pixel intensities
        return cv2.resize(image, size)

# construct the argument parse and parse the arguments

# grab the list of images that we'll be describing
print("[INFO] describing images...")
#imagePaths = list(paths.list_images(args["dataset"]))
imagePaths = glob.glob("barfigs/*.png")
# initialize the data matrix and labels list
imdata = []

# loop over the input images
for (i, imagePath) in enumerate(imagePaths):
        # load the image and extract the class label (assuming that our
        # path as the format: /path/to/dataset/{class}.{image_num}.jpg
        image = cv2.imread(imagePath)
        # construct a feature vector raw pixel intensities, then update
        # the data matrix and labels list
        features = imresize(image)
        cv2.imwrite(imagePath,features)
        data.append(features)

        