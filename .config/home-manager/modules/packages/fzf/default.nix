{ pkgs }:
let
    bin = "fzf";
    version = "0.65.2";

    uri_arch_name = if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then "arm64" else "amd64";

    target_file_name = "fzf-${version}-linux_${uri_arch_name}.tar.gz";

    # Quick script to get the checksums:
    # VERSION="0.65.2"
    # curl -sL https://github.com/junegunn/fzf/releases/download/v${VERSION}/fzf_${VERSION}_checksums.txt | \
    #     grep "linux_\(amd\|arm\)64" | \
    #     awk '{print $2 " = \"" $1 "\";"}' | \
    #     sed 's/^fzf[^ ]*\(amd64\|arm64\)\.tar\.gz/\1/'
    pkg_checksums = {
        amd64 = "5eb8efc0e94aa559f84ea83eeba99bea7dce818e63f92b4b62e60663220f1c14";
        arm64 = "097347160595bf03a426d2abe0a17e14ca060540ddfc0ea45c0a9be62bb29a2b";
    };
in
pkgs.stdenv.mkDerivation {
    pname = bin;
    version = version;

    src = pkgs.fetchurl {
        url = "https://github.com/junegunn/fzf/releases/download/v${version}/${target_file_name}";
        sha256 = pkg_checksums.${uri_arch_name};
    };

    phases = [ "installPhase" ];

    installPhase = ''
      tar -xzvf $src
      install -Dvm 755 ./fzf $out/bin/${bin}
    '';

}
