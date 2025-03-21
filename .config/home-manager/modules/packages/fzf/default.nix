{ pkgs }:
let
    bin = "fzf";
    version = "0.60.3";

    uri_arch_name = if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then "arm64" else "amd64";

    target_file_name = "fzf-${version}-linux_${uri_arch_name}.tar.gz";

    # Quick script to get the checksums:
    # curl -sL https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf_0.60.3_checksums.txt | \
    #     grep "linux_\(amd\|arm\)64" | \
    #     awk '{print $2 " = \"" $1 "\";"}' | \
    #     sed 's/^fzf[^ ]*\(amd64\|arm64\)\.tar\.gz/\1/'
    pkg_checksums = {
        amd64 = "2937a4f10b0f80e0c974d9459df3bc049b068a97212b0d253c36c9da5920b521";
        arm64 = "13df4d556992938a4beb340ac3b17c51c77e46db978d3071429eb77a94c581c1";
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
