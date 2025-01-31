{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[%](bold green)";
        error_symbol = "[%](bold red)";
      };
      directory = {
        truncation_length = 8;
        truncate_to_repo = false;
      };
    };
  };
}
