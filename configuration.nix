# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
    ];

  # OpenGL support in 32bit mode
hardware.opengl.driSupport32Bit = true;

  # Redshift display gamma shift daytime/nighttime adjustment
   services.redshift = {
    enable = true;
    latitude  = "49.8397";
    longitude = "24.0297";   
};

 #Garbage Collection
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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.firewall.allowedTCPPorts = [ 3000 5556 5558 8000 ];
 


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

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [

    alsaLib alsaPlugins alsaUtils

    libgphoto2 #to access digital cameras via usb

    feh #imageviewer

    qbittorrent

    blender

    #viber 

    vlc abiword qbittorrent okular
   
    unzip unrar wget vim 

    firefoxWrapper

    pavucontrol

    nodejs

    
  
     (import ./emacs.nix { inherit pkgs; }) 
    
 ];



  nixpkgs.config = { allowUnfree = true; };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.bash.enableCompletion = true;
   programs.mtr.enable = true;
  #programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  
    # Enable GNOME keyring (required for Evolution)
  services.gnome3.gnome-keyring.enable = true;

  virtualisation = {
    # Configure Docker (with socket activation):
    # Side note: ... why is this in virtualisation? ...
    docker.enable = true;
    docker.autoPrune.enable = true;
  };

  services.postgresql.enable = true;

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
   

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.onewithclouds = {
     isNormalUser = true;
     home = "/home/onewithclouds";
     description = "Andrew";
     extraGroups = [ "wheel" "networkmanager" ];
     initialPassword = "helloworld";
   };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?





}
