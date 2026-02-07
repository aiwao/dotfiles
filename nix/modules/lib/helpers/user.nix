{ config }:
let
  username = "aiwao";
  githubId = "233898056";
  email = "${githubId}+${username}@users.noreply.github.com";
in
{
  inherit username githubId email;
}
