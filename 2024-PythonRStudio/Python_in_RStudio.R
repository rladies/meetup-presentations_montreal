  #always run this -> selects the right env to use.
library(reticulate)
use_virtualenv('myenv')

library(reticulate)

  #Install Python
version <- '3.12.1'
install_python(version = version)

  #Create a virtual env
virtualenv_create('myenv',
                  python_version = version,
                  packages = c('numpy',
                               'pandas',
                               'matplotlib',
                               'seaborn'))
virtualenv_install('myenv', packages = 'plotly')
virtualenv_install('myenv', packages = 'scikit-learn')

  #Select venv
use_virtualenv('myenv')
py_config() #confirms which Python you're using











