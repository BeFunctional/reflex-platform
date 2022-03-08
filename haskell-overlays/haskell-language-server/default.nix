{ haskellLib, fetchFromGitHub, nixpkgs, thunkSet }:
with haskellLib;
let

  localDeps = thunkSet ./dep;
  hlsSrc = localDeps.haskell-language-server;

  hieSrc = hlsSrc + "/submodules/hie";
  hiePluginApiSrc = hlsSrc + "/hie-plugin-api";
  hieCompatSrc = hlsSrc + "/hie-compat";
  ghcideSrc = hlsSrc + "/ghcide";
  ghcModSrc = hlsSrc + "/submodules/ghc-mod";
  ghcProjectTypesSrc = ghcModSrc + "/ghc-project-types";
  ghcModCoreSrc = ghcModSrc + "/core";
  HaReSrc = hlsSrc + "/submodules/HaRe";
  cabalHelperSrc = hlsSrc + "/submodules/cabal-helper";
  hlsClassPluginSrc = hlsSrc + "/plugins/hls-class-plugin";
  hlsEvalPluginSrc = hlsSrc + "/plugins/hls-eval-plugin";
  hlsExplicitImportsPluginSrc = hlsSrc + "/plugins/hls-explicit-imports-plugin";
  hlsHlintPluginSrc = hlsSrc + "/plugins/hls-hlint-plugin";
  hlsPluginApiSrc = hlsSrc + "/hls-plugin-api";
  hlsRetriePluginSrc = hlsSrc + "/plugins/hls-retrie-plugin";
  shakeBenchSrc = hlsSrc + "/shake-bench";

in self: super: {
  _dep = super._dep or { } // localDeps;

  haskell-language-server = justStaticExecutables
    (dontCheck (self.callCabal2nix "haskell-language-server" hlsSrc { }));

  # Source dependencies of haskell-language-server
  cabal-helper =
    dontCheck (self.callCabal2nix "cabal-helper" cabalHelperSrc { });
  ghcide = dontCheck (self.callCabal2nix "ghcide" ghcideSrc { });
  hashable = self.callHackage "hashable" "1.3.5.0" { };
  ghc-mod-core =
    dontCheck (self.callCabal2nix "ghc-mod-core" ghcModCoreSrc { });
  ghc-mod = dontCheck (self.callCabal2nix "ghc-mod" ghcModSrc { });
  ghc-project-types =
    dontCheck (self.callCabal2nix "ghc-project-types" ghcProjectTypesSrc { });
  HaRe = dontCheck (self.callCabal2nix "HaRe" HaReSrc { });
  haskell-ide-engine =
    dontCheck (self.callCabal2nix "haskell-ide-engine" hieSrc { });
  hie-compat = dontCheck (self.callCabal2nix "hie-compat" hieCompatSrc { });
  hie-plugin-api =
    dontCheck (self.callCabal2nix "hie-ide-engine" hiePluginApiSrc { });
  hls-class-plugin =
    dontCheck (self.callCabal2nix "hls-class-plugin" hlsClassPluginSrc { });
  hls-eval-plugin =
    dontCheck (self.callCabal2nix "hls-eval-plugin" hlsEvalPluginSrc { });
  hls-explicit-imports-plugin = dontCheck
    (self.callCabal2nix "hls-explicit-imports-plugin"
      hlsExplicitImportsPluginSrc { });
  hls-hlint-plugin =
    dontCheck (self.callCabal2nix "hls-hlint-plugin" hlsHlintPluginSrc { });
  hls-plugin-api =
    dontCheck (self.callCabal2nix "hls-plugin-api" hlsPluginApiSrc { });
  hls-retrie-plugin =
    dontCheck (self.callCabal2nix "hls-retrie-plugin" hlsRetriePluginSrc { });

  shake-bench = dontCheck (self.callCabal2nix "shake-bench" shakeBenchSrc { });

  # Hackage dependencies of haskell-language-server
  fourmolu = dontCheck (self.callHackage "fourmolu" "0.3.0.0" { });
  ormolu = dontCheck (self.callHackage "ormolu" "0.1.4.1" { });
  with-utf8 = dontCheck (self.callHackage "with-utf8" "1.0.2.1" { });
  stylish-haskell =
    dontCheck (self.callHackage "stylish-haskell" "0.12.2.0" { });
  hie-bios = dontCheck (self.callHackage "hie-bios" "0.7.1" { });
  brittany = dontCheck (self.callHackage "brittany" "0.13.1.0" { });
  hls-tactics-plugin =
    dontCheck (self.callHackage "hls-tactics-plugin" "1.5.0.1" { });
  hls-brittany-plugin =
    dontCheck (self.callHackage "hls-brittany-plugin" "1.0.1.1" { });
  hls-call-hierarchy-plugin =
    dontCheck (self.callHackage "hls-call-hierarchy-plugin" "1.0.1.1" { });
  hls-ormolu-plugin =
    dontCheck (self.callHackage "hls-ormolu-plugin" "1.0.1.0" { });
  hls-graph = dontCheck (self.callHackage "hls-graph" "1.5.1.1" { });
  hls-refine-imports-plugin =
    dontCheck (self.callHackage "hls-refine-imports-plugin" "1.0.0.2" { });
  hls-pragmas-plugin =
    dontCheck (self.callHackage "hls-pragmas-plugin" "1.0.1.0" { });
  hls-splice-plugin =
    dontCheck (self.callHackage "hls-splice-plugin" "1.0.0.6" { });
  hls-stylish-haskell-plugin =
    dontCheck (self.callHackage "hls-stylish-haskell-plugin" "1.0.0.4" { });
  hls-test-utils = dontCheck (self.callHackage "hls-test-utils" "1.2.0.0" { });
  hls-module-name-plugin =
    dontCheck (self.callHackage "hls-module-name-plugin" "1.0.0.3" { });
  hls-haddock-comments-plugin =
    dontCheck (self.callHackage "hls-haddock-comments-plugin" "1.0.0.4" { });
  hls-floskell-plugin =
    dontCheck (self.callHackage "hls-floskell-plugin" "1.0.0.2" { });
  hls-fourmolu-plugin =
    dontCheck (self.callHackage "hls-fourmolu-plugin" "1.0.1.1" { });
  lsp = dontCheck (self.callHackage "lsp" "1.4.0.0" { });
  lsp-types = dontCheck (self.callHackage "lsp-types" "1.4.0.0" { });
  # needed by hiedb
  algebraic-graphs = dontCheck (self.callHackageDirect {
    pkg = "algebraic-graphs";
    ver = "0.6";
    sha256 = "3iD+pnCU6Q0hv6u7Qe5Rc6F5swLXTcZPtgN74aI1BK8=";
  } { });
  ghc-source-gen = dontCheck (self.callHackage "ghc-source-gen" "0.4.1.0" { });

  # Hackage dependencies of haskell-language-server that are broken with the default version
  floskell = dontCheck (self.callHackage "floskell" "0.10.4" { });

  # Hackage dependencies of ghcide
  ghc-check = dontCheck (self.callHackage "ghc-check" "0.5.0.3" { });
  heapsize = dontCheck (self.callHackage "heapsize" "0.3.0.1" { });
  implicit-hie-cradle =
    dontCheck (self.callHackage "implicit-hie-cradle" "0.3.0.2" { });
  opentelemetry = dontCheck (self.callHackage "opentelemetry" "0.6.1" { });
  lsp-test = dontCheck (self.callHackage "lsp-test" "0.11.0.5" { });
  shake = dontCheck (self.callHackage "shake" "0.19.2" { });

  # opentelemetry
  ghc-trace-events =
    dontCheck (self.callHackage "ghc-trace-events" "0.1.2.1" { });

  # Hackage dependencies of implicit-hie-cradle
  implicit-hie = dontCheck (self.callHackage "implicit-hie" "0.1.2.5" { });

  # Hackage dependencies of floskell that are broken with the default version
  monad-dijkstra = dontCheck (self.callHackage "monad-dijkstra" "0.1.1.2" { });

  # Hackage dependencies of fourmolu that are broken with the default version
  HsYAML-aeson = dontCheck (self.callHackage "HsYAML-aeson" "0.2.0.0" { });
  aeson = dontCheck (self.callHackage "aeson" "1.5.2.0" { });
  ghc-lib-parser =
    dontCheck (self.callHackage "ghc-lib-parser" "8.10.2.20200916" { });
  ghc-lib = dontCheck (self.callHackage "ghc-lib" "8.10.2.20200916" { });

  # Hackage dependencies of hls-hlint-plugin
  ghc-lib-parser-ex =
    dontCheck (self.callHackage "ghc-lib-parser-ex" "8.10.0.16" { });

  # Hackage dependencies of hls-retrie-plugin
  retrie = dontCheck (self.callHackage "retrie" "0.1.1.1" { });

  # Hackage dependencies of retrie
  optparse-applicative =
    dontCheck (self.callHackage "optparse-applicative" "0.15.1.0" { });
  ghc-exactprint = dontCheck (self.callHackage "ghc-exactprint" "0.6.2" { });

  # Hackage dependencies of aeson
  these = dontCheck (self.callHackage "these" "1.1.1.1" { });

  # Hackage dependencies of ormolu
  ansi-terminal = dontCheck (self.callHackage "ansi-terminal" "0.10.3" { });
  ansi-wl-pprint = dontCheck (self.callHackage "ansi-wl-pprint" "0.6.9" { });
  Diff = dontCheck (self.callHackage "Diff" "0.4.0" { });

  test-framework = dontCheck (self.callHackage "test-framework" "0.8.2.0" { });


  # Hackage dependencies of aeson
  primitive = dontCheck (self.callHackage "primitive" "0.7.1.0" { });

  # Hackage dependencies of hls-plugin-api
  haskell-lsp = dontCheck (self.callHackage "haskell-lsp" "0.22.0.0" { });
  haskell-lsp-types =
    dontCheck (self.callHackage "haskell-lsp-types" "0.22.0.0" { });
  regex-tdfa = dontCheck (self.callHackage "regex-tdfa" "1.3.1.0" { });
  regex-base = dontCheck (self.callHackage "regex-base" "0.94.0.0" { });
  regex-posix = dontCheck (self.callHackage "regex-posix" "0.96.0.0" { });

  tree-diff = dontCheck (self.callHackage "tree-diff" "0.1" { });
  parser-combinators =
    dontCheck (self.callHackage "parser-combinators" "1.2.1" { });

  # Hackage dependencies of hls-hlint-plugin
  hlint = dontCheck (self.callHackage "hlint" "3.2.3" { });

  # Hackage dependencies of hlint
  extra = dontCheck (self.callHackage "extra" "1.7.8" { });

  # Hackage dependencies of hls-tactics-plugin
  refinery = dontCheck (self.callHackage "refinery" "0.3.0.0" { });
  # Needed by hls
  hiedb = self.callHackage "hiedb" "0.4.1.0" { };
  lucid = dontCheck(super.lucid);
}
