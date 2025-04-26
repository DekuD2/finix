{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  version = "v1.19.0";
  pname = "bootdev";

  # modSha256 = "";  # Not sure what this is.

  src = fetchFromGitHub {
    owner = "bootdotdev";
    repo = "bootdev";
    rev = version;
    sha256 = "sha256-5S4XjqajX1Y9XKxfWFDeFVC2d14/C9fo6zytbwXuW7E=";
  };

  vendorHash = "sha256-jhRoPXgfntDauInD+F7koCaJlX4XDj+jQSe/uEEYIMM=";
  # subPackages = ".";

  meta = with lib; {
    description = "The official command line tool for Boot.dev. It allows you to submit lessons and do other such nonsense.";
    homepage = "https://github.com/bootdotdev/bootdev?tab=readme-ov-file#installation";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
