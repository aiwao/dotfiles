{
  username,
  ...
}: {
  environment.etc = {
    subuid.text = ''
      ${username}:100000:65536
    '';
    subgid.text = ''
      ${username}:100000:65536
    '';
  };
}
