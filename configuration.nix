let
    removeSuffix = suff: s: with builtins;
      let
        suffLen = stringLength suff;
        sLen = stringLength s;
      in
        if suff == substring (sLen - suffLen) sLen s then
            substring 0 (sLen - suffLen) s
        else
            s;
    here = toString ./.;
    name = removeSuffix "\n" (builtins.readFile ./hostname);
in
    import (here + "/local/" + name + ".nix")
