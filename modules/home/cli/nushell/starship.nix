{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      directory = {
        truncation_length = 8;
        truncate_to_repo = false;
      };
    };
  };
}
