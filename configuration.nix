# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
    myNixpkgs = import (builtins.fetchGit {
        name = "nixos-22.05-git";
        url = "https://github.com/NixOS/nixpkgs";
	ref = "nixos-22.05";
        rev = "cd90e773eae83ba7733d2377b6cdf84d45558780";
    }) {
       config = {
       	      allowUnfree = true;
              	};
    };

in 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#     ./vscode.nix
#      <home-manager/nixos> 
    ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  

    nixpkgs.config.allowUnfree = true;
    
    
    environment.systemPackages = with pkgs; [

    myNixpkgs.nodejs

    myNixpkgs.vscodium

    myNixpkgs.firefox myNixpkgs.chromium

    myNixpkgs.android-studio

    myNixpkgs.openjdk

    myNixpkgs.mongodb-compass

    myNixpkgs.mongodb

    myNixpkgs.postgresql_11

    myNixpkgs.pgadmin4

    # myNixpkgs.pgadmin3

    myNixpkgs.docker

    


    

    alsaLib alsaPlugins alsaUtils

    libgphoto2 #to access digital cameras via usb

    feh #imageviewer

    qbittorrent

    blender

    #viber

    #tor-browser-bundle-bin

    vlc abiword qbittorrent okular
   
    unzip unrar wget vim 



    audacity

    audacious
    
    pavucontrol
  
     (import ./emacs.nix { inherit pkgs; }) 
    
    ];




#to keep build-time dependencies around / be able to
#rebuild while being offline
# {
#   nix.extraOptions = ''
#     keep-outputs = true
#     keep-derivations = true
#   '';
# }




  # VSCode

#  vscode.user = "onewithclouds";
#   vscode.homeDir = "/home/onewithclouds"; 
#  vscode.extensions = with pkgs.vscode-extensions; [
#    bbenoist.Nix]  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
#  {
#    name = "vscode-eslint";
#    publisher = "dbaeumer";
#    version = "2.1.14";
#    sha256 = "113w2iis4zi4z3sqc3vd2apyrh52hbh2gvmxjr5yvjpmrsksclbd";
#  } ]; 



  # OpenGL support in 32bit mode
hardware.opengl.driSupport32Bit = true;

  # Redshift display gamma shift daytime/nighttime adjustment
   services.redshift = {
    enable = true;
    latitude  = "49.8397";
    longitude = "24.0297";   
};

  # Garbage Collection
   nix.gc.automatic = true;
   nix.gc.dates = "weekly";
   nix.gc.options = "--delete-older-than 30d";

 
 # Audio interface setup
  hardware.pulseaudio = {
  enable = true;
  support32Bit = true;
};
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

 
  # Networking
  networking.hostName = "nix"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.enableIPv6 = true;
      
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.firewall.allowedTCPPorts = [ 3000 5556 5558 8000 ];
 


  # Select internationalisation properties.
   i18n = {
     consoleFont = "";
   # consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
   time.timeZone = "Europe/Kiev";

  # Configure emacs:
  # (actually, that's a lie, this only installs emacs!)
#  services.emacs = {
#    install = true;
#    defaultEditor = true;
#    package = import ./emacs.nix { inherit pkgs; };
#  };











#   environment.systemPackages = with pkgs; [
#    alsaLib alsaPlugins alsaUtils
#    libgphoto2 #to access digital cameras via usb
#    feh #imageviewer
#    qbittorrent
#    blender
#    viber
#    tor-browser-bundle-bin
#    vlc abiword qbittorrent okular
#    unzip unrar wget vim 
#    firefox
#    chromium
#    opera
#    audacity
#    audacious
#    pavucontrol
#    vscodium
#     (import ./emacs.nix { inherit pkgs; }) 
# ];





 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.bash.enableCompletion = true;
   programs.mtr.enable = true;
   programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  #MongoDB
  services.mongodb.enable = true;
  
  # Enable GNOME keyring (required for Evolution)
  # services.gnome3.gnome-keyring.enable = true;

  # Tor
  # services.tor.enable = true;
  # services.tor.client.enable = true;

  virtualisation = {
    # Configure Docker (with socket activation):
    docker.enable = true;
    docker.autoPrune.enable = true;
  };




  # services.postgresql.enable = true;

services.postgresql = {
    enable = true;
    package = myNixpkgs.postgresql_11;
    dataDir = "/postgresql";
    # extraPlugins = [pkgs.postgis];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 11 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';

    initialScript = myNixpkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
    };





  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us, ru, ua";
   services.xserver.xkbVariant = " workman ";
   services.xserver.xkbOptions = "grp : alt_shift_toggle";

  # Enable touchpad support.
    services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
    services.xserver.displayManager.sddm.enable = true; 
    services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;
   

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.onewithclouds = {
     isNormalUser = true;
     home = "/home/onewithclouds";
     description = "Andrew";
     extraGroups = [ "wheel" "networkmanager" "docker" ];
     initialPassword = "helloworld";
   };


   users.users.eve = {
     isNormalUser = true;
     home = "/home/eve";
     description = "Eve";
     extraGroups = [ "wheel" "networkmanager" ];
     initialPassword = "helloworld";
   };

#    users.users.eve.isNormalUser = true;

#    home-manager.users.onewithclouds = { pkgs, ... }: {
#    home.packages = [ pkgs.atool pkgs.httpie pkgs.nodejs-14_x ];
#    programs.bash.enable = true;
#    };



  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "22.05"; # Did you read the comment?





}
