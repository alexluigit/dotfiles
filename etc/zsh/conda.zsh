# Automatically activate conda env
source /opt/miniconda/etc/profile.d/conda.sh
__conda_env_exist() { [[ -d ./envs ]] && [[ -f ./environment.yml ]]; }
_chpwd_conda_auto_switch () {
  $(__conda_env_exist) && conda activate ./envs || conda deactivate
}

conda_activate_local() {
  conda create --prefix ./envs
  conda env update --prefix ./envs -f ${1:-environment.yml} --prune
  conda activate ./envs
}

_chpwd_conda_auto_switch
$CONDA_AUTOSWITCH && chpwd_functions+=(_chpwd_conda_auto_switch)
