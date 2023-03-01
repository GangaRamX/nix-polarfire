let
  icicle-kit = import ./icicle-kit;
  host = import ./host;
in
  icicle-kit // host
