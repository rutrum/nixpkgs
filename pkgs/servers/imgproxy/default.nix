{ lib, buildGoModule, fetchFromGitHub, pkg-config, vips, gobject-introspection
, stdenv, libunwind }:

buildGoModule rec {
  pname = "imgproxy";
  version = "3.16.1";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    sha256 = "sha256-l5THMK6YUfScTeralhEl5SDBDoeV3Olt1xzdzeJ8BEQ=";
    rev = "v${version}";
  };

  vendorHash = "sha256-EtNFSAx8YcRhzgV3IdrZaCM6fOd284iuTperCFECsL8=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gobject-introspection vips ]
    ++ lib.optionals stdenv.isDarwin [ libunwind ];

  preBuild = ''
    export CGO_LDFLAGS_ALLOW='-(s|w)'
  '';

  meta = with lib; {
    description = "Fast and secure on-the-fly image processing server written in Go";
    homepage = "https://imgproxy.net";
    changelog = "https://github.com/imgproxy/imgproxy/blob/master/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ paluh ];
  };
}
