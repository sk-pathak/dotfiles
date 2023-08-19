# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit=5;
  boot.loader.efi.canTouchEfiVariables = true;

  # NTFS
  boot.supportedFilesystems=["ntfs"];
  system.fsPackages=[pkgs.ntfs3g];
  fileSystems."/run/media/sumit_pathak/Disk1"={
     device="/dev/sda2";
     fsType="ntfs3";
     options=["force" "rw" "uid=1000" "nofail"];
  };
  fileSystems."/run/media/sumit_pathak/Disk2"={
     device="/dev/sda3";
     fsType="ntfs3";
     options=["force" "rw" "uid=1000" "nofail"];
  };
  fileSystems."/run/media/sumit_pathak/OS"={
     device="/dev/nvme0n1p3";
     fsType="ntfs3";
     options=["force" "rw" "uid=1000" "nofail"];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime=true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
 # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.excludePackages=[pkgs.xterm];
    # services.xserver.libinput.enable = true;

  # sessionVariables
  environment.sessionVariables=rec{
     XDG_BIN_HOME="$HOME/.local/bin";
     PATH=[
	"${XDG_BIN_HOME}"
     ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sumit_pathak = {
    isNormalUser = true;
    description = "Sumit Pathak";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     firefox
     graphviz
     git
     neofetch
     ntfs3g
     python311
     python311Packages.pip
     pipx
     fuse
     numlockx
     vlc
     vscode
     gnugrep
     htop
     dos2unix
     powertop
     power-profiles-daemon
     thermald
     neovim
     starship
     autojump
     cmatrix
     gnomeExtensions.control-blur-effect-on-lock-screen
     gnomeExtensions.blur-my-shell
     gnome.gdm
     gnome.gnome-shell-extensions
     gnomeExtensions.user-themes
     gnomeExtensions.vitals
     gnomeExtensions.dash-to-dock
     gnomeExtensions.appindicator
     gnome.gnome-tweaks
     gnomeExtensions.tweaks-in-system-menu
     gnome.mutter43
];


# Fonts
  fonts={
     enableDefaultFonts=true;
     fonts=with pkgs;[
	jetbrains-mono
	fira-code
	hack-font
        (nerdfonts.override {fonts=["JetBrainsMono"];})
    ];
     fontconfig={
	enable=true;
	defaultFonts={
	   monospace=["Hack JetBrainsMono FiraCode"];
	};
      };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
