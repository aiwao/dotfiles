{
  username,
  ...
}: {
  environment.etc = {
    subuid = {
      text = ''
        ${username}:100000:65536
      '';
      replaceExisting = true;
    };
    subgid = {
      text = ''
        ${username}:100000:65536
      '';
      replaceExisting = true;
    };
  };
}
