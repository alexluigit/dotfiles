# Automatically activate base python venv

# Disable venv's default prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ -d $XDG_DATA_HOME/python ]] || python3 -m venv $XDG_DATA_HOME/python

__venv_activate_base() { source $XDG_DATA_HOME/python/bin/activate; }
__venv_activate_current() {
  local proj=$(git rev-parse --show-toplevel 2>/dev/null)
  local attempts=(".venv" "venv" "$proj");
  local venv=""
  for dir in $attempts; do
    [[ -f $dir/bin/activate ]] && { . $dir/bin/activate; venv=1; break; }
  done
  [[ -z $venv ]] && echo "No virtual environment found, try activate manually";
  return 0;
}

__venv_activate_base
