# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let sshKeys = import ./sshKeys.nix;
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./minecraft.nix
    ];

  ## Boot ##
  boot.supportedFilesystems = [ "zfs" ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.devices = [ "/dev/sda" "/dev/sdb" ];
  # Emergency shell in case of failure.
  boot.initrd.network.enable = true;
  boot.initrd.network.ssh.enable = true;
  boot.initrd.network.ssh.authorizedKeys = sshKeys.svein;
  boot.initrd.network.ssh.hostDSSKey = /etc/nixos/ssh_initrd_host_key;
  # Start up if at all possible.
  systemd.enableEmergencyMode = false;
  # Set noop elevator to make ZFS a little faster.
  boot.postBootCommands = ''
    echo noop > /sys/block/sda/queue/scheduler
    echo noop > /sys/block/sdb/queue/scheduler
  '';

  # Reserve huge pages for Minecraft.
  boot.kernelParams = [
    "hugepages=4096"
  ];
  boot.kernel.sysctl = {
    "kernel.shmmax" = 12884901888;
    "vm.hugetlb_shm_group" = 100;  # users
  };
  security.pam.loginLimits = [
    {
      domain = "minecraft";
      type = "-";
      item = "memlock";
      value = "16777216";
    }
   ];

  boot.cleanTmpDir = true;

  ## Networking ##
  networking.hostName = "madoka.brage.info";
  networking.hostId = "f7fcf93e";
  networking.defaultGateway = "138.201.133.1";
  # Doesn't work due to missing interface specification.
  #networking.defaultGateway6 = "fe80::1";
  networking.localCommands = ''
    ${pkgs.nettools}/bin/route -6 add default gw fe80::1 dev enp0s31f6
  '';
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.interfaces.enp0s31f6 = {
    ip6 = [{
      address = "2a01:4f8:172:3065::2";
      prefixLength = 64;
    }];
  };
  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 80 443 25565 25566 4000 12345 ];
    allowedUDPPorts = [
      34197 # Factorio
    ];
  };
  networking.firewall.allowedUDPPortRanges = [{from = 60000; to = 61000;}];

  ## Security ##
  security.sudo.wheelNeedsPassword = false;
  security.apparmor.enable = true;
  services.fail2ban.enable = true;

  ## Locale ##
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  time.timeZone = "Europe/Dublin";

  ## Services ##
  #services.zfs.autoSnapshot.enable = true;
  services.locate.enable = true;

  # SSH
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # Gitlab
  services.gitlab = {
    enable = false;
    # emailFrom = "svein@madoka.brage.info";
    port = 443;
    https = true;
    databasePassword = (import ./gitlab-pw.nix).db;
    initialRootPassword = (import ./gitlab-pw.nix).root;
  };

  ## Email & cron ##
  services.cron.enable = true;
  services.cron.mailto = "svein";
  services.postfix.enable = true;

  ## Users ##
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.svein = {
    isNormalUser = true;
    uid = 1004;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = sshKeys.svein;
  };
  users.extraUsers.minecraft = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ ];
    openssh.authorizedKeys.keys = builtins.concatLists (lib.attrValues sshKeys);
  };
  users.extraUsers.bloxgate = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ ];
    openssh.authorizedKeys.keys = sshKeys.bloxgate;
  };
  users.extraUsers.buizerd = {
    isNormalUser = true; 
    uid = 1010;
    openssh.authorizedKeys.keys = sshKeys.buizerd;
  };
  users.extraUsers.darqen27 = {
    isNormalUser = true; 
    uid = 1007;
    extraGroups = [ ];
    openssh.authorizedKeys.keys = sshKeys.darqen27;
  };
  users.extraUsers.david = {
    isNormalUser = true; 
    uid = 1005;
  };
  users.extraUsers.jmc = {
    isNormalUser = true; 
    uid = 1003;
    extraGroups = [ ];
    shell = "/run/current-system/sw/bin/bash";
    openssh.authorizedKeys.keys = sshKeys.jmc;
  };
  users.extraUsers.kim = {
    isNormalUser = true; 
    uid = 1002;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = sshKeys.kim;
  };
  users.extraUsers.luke = {
    isNormalUser = true; 
    uid = 1006;
    extraGroups = [ ];
    openssh.authorizedKeys.keys = sshKeys.luke;
  };
  users.extraUsers.simplynoire = {
    isNormalUser = true; 
    uid = 1009;
  };
  users.extraUsers.vindex = {
    isNormalUser = true; 
    uid = 1011;
    extraGroups = [ ];
    openssh.authorizedKeys.keys=sshKeys.vindex;
  };
  users.extraUsers.xgas = {
    isNormalUser = true;
    uid = 1012;
    openssh.authorizedKeys.keys = sshKeys.xgas;
  };


  ## Webserver ##
  services.nginx.enable = true;
  services.nginx.httpConfig = builtins.readFile ./nginx/nginx.cfg;
  security.acme.certs = {
    "madoka.brage.info" = {
      webroot = "/var/spool/nginx/letsencrypt";
      email = "sveina@gmail.com";
      user = "nginx";
      group = "nginx";
      postRun = "systemctl reload nginx.service";
      extraDomains = {
        "status.brage.info" = null;
        "znc.brage.info" = null;
        "alertmanager.brage.info" = null;
        "map.brage.info" = null;
        "cache.brage.info" = null;
        "incognito.brage.info" = null;
        "grafana.brage.info" = null;
        "quest.brage.info" = null;
        "tigersight.brage.info" = null;
        "w2.brage.info" = null;
        "warmroast.brage.info" = null;
        "wiki.brage.info" = null;
        "gitlab.brage.info" = null;
        "matter.brage.info" = null;
      };
    };
  };

  ## Docker
  # virtualisation.docker.enable = true;
  # virtualisation.docker.storageDriver = "zfs";
  # virtualisation.docker.socketActivation = false;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  ## Software ##
  system.autoUpgrade.enable = true;
  nix.extraOptions = "auto-optimise-store = true";
  nix.gc.automatic = false;
  nix.gc.dates = "Thu 03:15";
  nix.gc.options = "--delete-older-than 14d";
  nix.useSandbox = true;
  environment.systemPackages = with pkgs; [
    tcpdump psmisc gdb stack wget file zip irssi links telnet unison
    git mutt openjdk unzip imagemagick parallel moreutils vim nix-repl whois
    znc bsdgames shared_mime_info nox emacs24-nox hdparm nmap sysstat 
    screen atop rsync znapzend
  ];
  programs.zsh.enable = true;
  programs.mosh.enable = true;
  nixpkgs.config.allowUnfree = true;

#  zramSwap.enable = true;

  # VPN
  services.openvpn = {
    servers = {
      server = {
        config = ''
          dev tun
          ifconfig 10.8.0.1 10.8.0.2
          secret /root/static.key
          comp-lzo
        '';
        up = "ip route add ...";
        down = "ip route del ...";
	autoStart = true;
      };
    };
    
  };

  # Workaround for inpure's server.
  networking.extraHosts = ''
    0.0.0.0 files.inpureprojects.info
  '';
}
