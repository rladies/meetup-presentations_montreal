### Setup instructions

**Please complete steps 1 through 3 before the workshop!**

1. Please download R and RStudio before the lecture: 
  - [R](https://cran.r-project.org/)
  - [RStudio desktop](https://www.rstudio.com/products/rstudio/#Desktop)

2. Please install the packages dplyr, ggplot2 and plotly:
  - Open RStudio. Click the "Packages" tab in the lower right window. Click "Install" and type in dplyr in the packages text box and click "Install". Repeat this step for the other two packages.
  - After you do this type "library(dplyr)" into the console (bottom left). Messages should appear, but warnings/failure message should not. Also load ggplot2 and plotly using the library() command.

3. Duplicate the contents of this folder (20180419_ggplot) onto your computer, including the .Rproj file, the data files, and the workshop code file. Keep the same directory structure (i.e., make sure the workshop.R file is within a subdirectory called Code/ and the data files are within a subdirectory called Data/). The two most easy ways to do this is by using `git clone` to clone the R-Ladies Montreal [entire directory](https://github.com/rladies/meetup-presentations_montreal) or clicking the download link on [this page](https://github.com/rladies/meetup-presentations_montreal) to download the entire directory. Alternatively, you can navigate to each file and download them individually if you do not want to also have the last meetup's files.

4. If RStudio is open, close it. Launch RStudio by opening the 20180419_ggplot.Rproj file. On Mac, you’ll see that the RStudio window has listed the project’s directory at the top. Look in the File Viewer panel and see the files you downloaded. Type getwd() in the code console. Notice the pathway points to your folder.

5. Open the Workshop file in RStudio by selecting it from the file list.

6. During the workshop, we will follow the instructions in the R script to learn how to use dplyr, ggplot2, and plotly. A copy of the solutions will be added to this folder after the workshop.
