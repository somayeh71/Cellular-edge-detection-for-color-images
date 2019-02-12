# Cellular-edge-detection-for-color-images



Abstract

Edge detection is considered as an important feature for image processing in computer vision. Due to the fact that grayscale images loss some information there is a need to work on color images edge detection. Besides, converting a color image to a gray one is a time consuming task and reduces the speed of computing. In this study we propose a CED algorithm based on CA and CLA which is a very accurate and reliable way of edge detecting. Every color edge detection procedure is done via the grayscale rules but the only difference is the input image. Results shows that this new way to find edges work accurately and more efficient. The evaluation of this proposed model calculated by MSE and PSNR. 

Key word: CED (Cellular Edge Detection), color image edge detection, CA (Cellular automata), CLA (Cellular Learning Automata).

--------------------------------------------------


colorCED.m  ------> is our method for  edge detection in color images.
Results.m   ------>  calculate evaluation by MSE and PSNR.

(CLA_G_ED_final.m/actionSelector.m/windowMoore.m / windowVonNeumann.m ) ------> are for Cellular edge detection in gray images.

colorcanny.m /VG_edges.m/ ------>  are other methods for edge detection in color images.

 
*** Run (surveym.m ) and you will get mask of edges with all these methods and PSNR & MSE for each mask.

