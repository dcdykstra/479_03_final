# Amazon US Customer Reviews Sentiment Analysis

## Start
- Put all the files from the folders 'setup_files' and 'run_files' into the same directory

### Setup Files
#### Setup required in order to run the CHTC job.
- interactive.sub
  - Run an interactive job on CHTC in order to download R and gain access to a command line on the compute node
  - condor_submit -i "interactive.sub"
- install_R.sh
  - Downloads the required packages "tidyverse", "caret", and "tidytext" into packages.tar.gz in your directory
  - Run it once in the interactive job
  - ./install_R.sh
- build.sh
  - Creates filenames.txt instead of manually typing it out
  - Don't run it in the interactive job
  - ./build.sh

### Run Files
#### The only files you need to run the CHTC job. The queue process is as follows.
- job.sub
  - Run first to create 74 .tsv files. 37 train.tsv files and 37 test.tsv files
  - Utilizes 'pre_proj.R', 'exec.sh', 'afinn.csv', and 'filenames.txt'
  - Directory requires /log/, /error/, /output/
  - Packages requried are "tidyverse", "caret", and "tidytext"
    - They can be obtained from 'setup_files'
    - condor_submit -i "interactive.sub"
    - ./install_R.sh
- mid.sh
  - Run this second to create train.csv and test.csv
  - This must be run prior to running job2.sub
- job2.sub
  - Finally run this to create your output files 'lm.txt', and 'conf_mat.txt'
  - Utilizes 'proj.R' and 'post.sh'

### Out Files
- lm.txt
  - Output of lm(formula = star_rating ~ sentiment + helpful_votes + vine, data = train.csv)
- conf_mat.txt
  - Output of confusionMatrix(y_pred_cat, y_true) from the "caret" package

### Visualize
- visualize.rmd
  - Creates and saves the bar plots and density plots showing the comparison of each predicted star rating to its actual star rating
  - Requires test.csv and train.csv in the directory
