{ pkgs, nixvim, ... }: {
  imports = [ nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    opts = {
      tabstop = 4;
      shiftwidth = 4;
      wrap = false;
      expandtab = true;
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      colorcolumn = "80";
      guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block";
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>pv,";
        options.silent = true;
        action = ":Ex<CR>";
      }
      {
        mode = "n";
        key = "<leader>g";
        options.silent = true;
        action = ":Git<CR>";
      }
      {
        mode = "n";
        key = "<leader>ff";
        options.silent = true;
        action = ":Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = ":Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        options.silent = true;
        action = ":Telescope buffers<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        options.silent = true;
        action = ":Telescope help_tags<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = ":Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = ":Telescope live_grep<CR>";
      }
    ];
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    colorschemes.gruvbox.enable = true;
    globalOpts = { hlsearch = false; };
    plugins = {
      gitsigns.enable = true;
      telescope.enable = true;
      fugitive.enable = true;
      wakatime.enable = true;
      web-devicons.enable = true;
      harpoon = {
        enable = true;
        keymaps = {
          addFile = "<C-a>";
          cmdToggleQuickMenu = "<C-q>";
        };
      };
    };
  };
}
