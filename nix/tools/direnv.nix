{}: {
  enable = true;
  stdlib = ''
    layout_poetry() {
      PYPROJECT_TOML="''${PYPROJECT_TOML:-pyproject.toml}"
      if [[ ! -f "$PYPROJECT_TOML" ]]; then
          log_status "No pyproject.toml found. Executing \`poetry init\` to create a \`$PYPROJECT_TOML\` first."
          poetry init
      fi

      PYTHON_PATH=$(poetry run which python)
      echo $PYTHON_PATH

      if [[ -z $PYTHON_PATH || ! -f $PYTHON_PATH ]]; then
          log_status "No virtual environment exists. Executing \`poetry install\` to create one."    
          poetry install
          PYTHON_PATH=$(poetry run which python)
      fi
      BIN_PATH=$(dirname $PYTHON_PATH)
      VIRTUAL_ENV=$(dirname $BIN_PATH)

      PATH_add "$BIN_PATH"
      export POETRY_ACTIVE=1
      export VIRTUAL_ENV
    }
  '';
  nix-direnv = {
    enable = true;
  };
}
