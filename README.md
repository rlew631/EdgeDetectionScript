# EdgeDetectionScript
works with black and white images, de-noises them and detects edges

The path for the dog picture is an absolute filepath so you'll need to change it to work on your computer. This was done as a personal project to figure out a good way to do edge detection.

The method used here takes a 4x4 matrix, breaks it up into quarters and determines if there's a difference in color between the top/bottom or left/right. The "edge strength" values are used to change the amount of color difference allowed between the halves with a higher number being less sensetive.

The algorithm was written WET and could be cleaned up, but the purpose here was to show the different thresholds, not write minimalistic code so a significant amount could be cut out in a production setting anyways. Additionally the edge detection could be more thorough if the top/bottom and left/right parameters had two seperate if/elseif statements instead of one. This would result in a + being displayed for that location instead of a horizontal line. Since the box being used to detect edges is small this most likely wouldn't produce a visibly noticable difference for the few instances where this occurs.

The first row of images shows (from left to right) the original image, the image with a slight gaussian blur applied, the image with a stronger gaussian blur applied.

The second row of images shows (from left to right) the slight gaussian blur image with 3 increasing levels of contrast applied.

The third row of images shows (from left to right) the middle contrast image with 3 different strength levels of edge detection applied.

The values chosen were found to be the best for this image but would vary depending on the original image being used. In order to use this technique on a color image it would probably make the most sense to work in the HSV colorspace and look for variances in any of those values.
