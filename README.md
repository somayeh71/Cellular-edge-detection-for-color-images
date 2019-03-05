Cellular edge detection for color images
Somayeh Golmohamadi, Elnaz Ahmadi Shad, Mohammadreza Asghari Oskoei
Department of computer science
Allameh Tabatabai university
Tehran, Iran




Abstract
dge detection is considered an important feature for image processing in computer science. However, today this technology has mainly be  devoped for grey scale images  as opposed to coloured images. Converting to greyscale images ivolves information loss and is often time consuming. We therefore see a need to develop edge detection for colour images as well.
In this study we propose a CED algorithm based on CA and CLA which is a very accurate and reliable way of edge detecting. Every color edge detection procedure is done via the grayscale rules but the only difference is the input image. Results shows that this new way to find edges work accurately and more efficient. The evaluation of this proposed model calculated by MSE and PSNR. 


Key word: CED (Cellular Edge Detection), color image edge detection, CA (Cellular automata), CLA (Cellular Learning Automata).


--------------------------------------------------


colorCED.m  ----------------------------------------------------------------->  our method for  edge detection in color images.
Results.m   ----------------------------------------------------------------->  calculate evaluation by MSE and PSNR.

(CLA_G_ED_final.m/actionSelector.m/windowMoore.m / windowVonNeumann.m ) ------> are for Cellular edge detection in gray images.

colorcanny.m /VG_edges.m/ ------------------------------------------------->  are other methods for edge detection in color images.

 
       *** Run (surveym.m ) -----------> you will get mask of edges with all these methods and PSNR & MSE for each mask.

 you can find the results of survey.m in a pdf file here.
