{
  description = "My personal tools for simplifying development.";

  inputs = { };

  outputs = { self }:
  let
    system = "x86_64-linux";
  in
  {
    lib.${system} = {
      mk_prepare_venv = {writeScriptBin, python-with-packages, venvDir ? ".venv"}: (writeScriptBin "prepare_venv.nu" ''
        #!/usr/bin/env nu
        # Create virtualenv if doesn't exist
        if not ("./${venvDir}" | path exists) {
          print "creating venv..."
          virtualenv "./${venvDir}" --python="${python-with-packages}/bin/python3" --system-site-packages
          $env.PYTHONHOME = "${python-with-packages}"  # This has to be set AFTER creating virtualenv but BEFORE installing requirements. That is because the --system-site-packages tells the virtualenv to use system packages when they are available (such as the tricky numpy package).

          if (requirements.txt | path exists) {
            print "installing dependencies... ('pip install -r requirements.txt')"
            ${venvDir}/bin/pip install -r requirements.txt
          }
          if (setup.py | path exists) or (pyproject.toml | path exists) {
            print "installing dependencies... ('pip install -e .')"
            ${venvDir}/bin/pip install -e .
          }
        } else {
          print "venv already exists"
        }

        $env.PYTHONHOME = "${python-with-packages}"
      '');
    };
  };
}

