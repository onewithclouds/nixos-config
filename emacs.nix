
{ pkgs }:

let
  myEmacs = pkgs.emacs.override {
    withGTK3 = true;
    withGTK2 = false;
  };
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.elpaPackages; [
    ace-window
    auctex
  ]) ++ (with epkgs.melpaStablePackages; [
    company-go
    flycheck
    git-gutter
    go-mode
    haskell-mode
    highlight-parentheses
    lua-mode
    magit
    markdown-mode
    nix-mode
    projectile
    smartparens
    smooth-scrolling
    use-package
    which-key
    helm
    helm-ls-git
    powerline
    spaceline
    hyde
    org-bullets
    yasnippet
    helm-projectile
    xkcd
    diminish
  ]) ++ (with epkgs.melpaPackages; [
    editorconfig
    company-lua
    rust-mode
    web-mode
    latex-preview-pane
  ]))
