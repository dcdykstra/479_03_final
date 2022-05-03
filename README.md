# Amazon US Customer Reviews Sentiment Analysis

### Run Files
#### The only files you need to run the CHTC job. The queue process is as follows.
- job.sub
  - Run first to create 74 .tsv files. 37 train.tsv files and 37 test.tsv files.
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
