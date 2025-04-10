{
  description = "My personal tools for simplifying development.";

  inputs = { };

  outputs = { self }:
  let
    system = "x86_64-linux";
  in
  {
    lib.${system} = {
      mkprepare_venv = {writeShellScriptBin, python-with-packages, venvDir ? ".venv"}: (writeShellScriptBin "prepare_venv.sh" ''
        # Create virtualenv if doesn't exist
        if test ! -d "./${venvDir}"; then
          echo "creating venv..."
          virtualenv "./${venvDir}" --python="${python-with-packages}/bin/python3" --system-site-packages
          export PYTHONHOME="${python-with-packages}"  # This has to be set AFTER creating virtualenv but BEFORE installing requirements. That is because the --system-site-packages tells the virtualenv to use system packages when they are available (such as the tricky numpy package).

          if test -f requirements.txt; then
            echo "installing dependencies... ('pip install -r requirements.txt')"
            ${venvDir}/bin/pip install -r requirements.txt
          fi
          if test -f setup.py || test -f pyproject.toml; then
            echo "installing dependencies... ('pip install -e .')"
            ${venvDir}/bin/pip install -e .
          fi
        fi

        export PYTHONHOME="${python-with-packages}"
      '');
    };
  };
}

