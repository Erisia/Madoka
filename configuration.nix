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
      ./mediawiki.nix
#      ./hydra.nix
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

#  # Reserve huge pages for Minecraft.
#  boot.kernelParams = [
#    "hugepages=4096"
#  ];
#  boot.kernel.sysctl = {
#    "kernel.shmmax" = 12884901888;
#    "vm.hugetlb_shm_group" = 100;  # users
#  };
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
    allowedTCPPorts = [ 
      80 443  # Web-server. (nginx)
      25565 25566 25567  # Minecraft
      4000  # ZNC
      # 4001  # IPFS
      12345  # JMC's ZNC
    ];
    allowedUDPPorts = [
      34197 # Factorio
    ];
  };
  networking.firewall.allowedUDPPortRanges = [{from = 60000; to = 61000;}];
  networking.nat = {
    enable = true;  # For mediawiki.
    externalIP = "138.201.133.39";
    externalInterface = "enp0s31f6";
    internalInterfaces = [ "ve-eln-wiki" ];
  };

  ## Security ##
  security.sudo.wheelNeedsPassword = false;
  security.pam.enableGoogleAuth = true;
  services.openssh.passwordAuthentication = true;  # Ok because we require OTP.
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

  # IPFS
  # services.ipfs.enable = true;
  # services.ipfs.enableGC = true;

  # SSH
  services.openssh.enable = true;

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

  # Next free ID: 1019.
  users.extraUsers.svein = {
    isNormalUser = true;
    uid = 1004;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = sshKeys.svein;
  };
  users.extraUsers.mei = {
    isNormalUser = true;
    uid = 1017;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMZr+a9w5b6VyqkdNbepBSkjpKQBdAZHJRCRS9SnqVubQIhYg6WsYYOtjp0GKM2SK5MqcrLUQYiT2LDUFOtC4zFxgCcZ6IoAcVqDCiZH8oeDkZlo/Qv0boKovOAGxqf0IdC+KMDhDDMBczuhOECUonFi6ArsXg9JbRJ1xDkTvIftFyypcdM9LDFAxIEEMqx6iIu0ANLvSNvI4xLjiav9tP8+Ea5TPBTm4H0EpsJNA3YsQPuC5TvbVH0kIl1NTdG1CjeZgiMSAAQoNy15Ik1EDoCp/eRO9JzRYNmU4/Z+af5Ns6SP1e/uSYkxoQNneSSWzPRagdNbTN+wVKJ91qaFVL mei@mei-hevs"
    ];
  };
  users.extraUsers.einsig = {
    isNormalUser = true;
    uid = 1014;
    openssh.authorizedKeys.keys = sshKeys.einsig;
  };
  users.extraUsers.prospector = {
    isNormalUser = true;
    uid = 1015;
    openssh.authorizedKeys.keys = sshKeys.prospector;
  };
  users.extraUsers.minecraft = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ ];
    openssh.authorizedKeys.keys = builtins.concatLists (lib.attrValues sshKeys);
  };
  users.extraUsers.tppi = {
    isNormalUser = true;
    uid = 1013;
    openssh.authorizedKeys.keys = builtins.concatLists [
      sshKeys.svein sshKeys.kim sshKeys.luke sshKeys.prospector
    ];
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
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    sslDhparam = ./nginx/dhparams.pem;
    statusPage = true;
    appendHttpConfig = ''
      add_header Strict-Transport-Security "max-age=31536000; includeSubdomains";
      add_header X-Clacks-Overhead "GNU Terry Pratchett";
      autoindex on;

      # Fallback config for Erisia
      upstream erisia {
        server 127.0.0.1:8123;
	server unix:/home/minecraft/erisia/staticmap.sock backup;
      }
      server {
        listen unix:/home/minecraft/erisia/staticmap.sock;
	location / {
	  root /home/minecraft/erisia/dynmap/web;
	}
      }
      # Ditto, Incognito.
      # TODO: Factor this. Perhaps send a PR or two.
      upstream incognito {
        server 127.0.0.1:8124;
	server unix:/home/minecraft/incognito/staticmap.sock backup;
      }
      server {
        listen unix:/home/minecraft/incognito/staticmap.sock;
	location / {
	  root /home/minecraft/incognito/dynmap/web;
	}
      }
      upstream tppi {
        server 127.0.0.1:8126;
        server unix:/home/tppi/server/staticmap.sock backup;
      }
      server {
        listen unix:/home/tppi/server/staticmap.sock;
        location / {
          root /home/tppi/server/dynmap/web;
        }
      }
      
    '';
    virtualHosts = let
      base = locations: {
        forceSSL = true;
	enableACME = true;
        inherit locations;
      };
      proxy = port: base {
        "/".proxyPass = "http://localhost:" + toString(port) + "/";
      };
      root = dir: base {
        "/".root = dir;
      };
    in {
      "madoka.brage.info" = base {
        "/" = {
	  root = "/home/minecraft/web";
	  tryFiles = "\$uri \$uri/ =404";
	};
	"/warmroast".proxyPass = "http://localhost:23000/";
	"/baughn".extraConfig = "alias /home/svein/web;";
	"/tppi".extraConfig = "alias /home/tppi/web;";
      } // { default = true; };
      "status.brage.info" = proxy 9090;
      "tppi.brage.info" = root "/home/tppi/web";
      "alertmanager.brage.info" = proxy 9093;
      "map.brage.info" = base { "/".proxyPass = "http://erisia"; };
      "incognito.brage.info" = base { "/".proxyPass = "http://incognito"; };
      "tppi-map.brage.info" = base { "/".proxyPass = "http://tppi"; };
      "cache.brage.info" = root "/home/svein/web/cache";
      "znc.brage.info" = base { 
         "/" = {
           proxyPass = "https://localhost:4000";
           extraConfig = "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;";
         };
      };
      "quest.brage.info" = proxy 2222;
      "warmroast.brage.info" = proxy 23000;
      "wiki.brage.info" = base {
        "/" = {
	  proxyPass = "http://192.168.10.2";
	  extraConfig = "rewrite ^(/)$ http://wiki.brage.info/wiki/ permanent;";
	};
      };
      "hydra.brage.info" = proxy 3001;
    };
  };

  ## Docker
  # virtualisation.docker.enable = true;
  # virtualisation.docker.storageDriver = "zfs";
  # virtualisation.docker.socketActivation = false;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  ## Software ##
  #system.autoUpgrade.enable = true;
  nix.extraOptions = "auto-optimise-store = true";
  nix.gc.automatic = false;
  nix.gc.dates = "Thu 03:15";
  nix.gc.options = "--delete-older-than 14d";
  nix.useSandbox = "relaxed";
  environment.systemPackages = with pkgs; [
    tcpdump psmisc gdb stack wget file zip irssi links telnet unison
    git mutt openjdk unzip imagemagick parallel moreutils vim nix-repl whois
    znc bsdgames shared_mime_info nox hdparm nmap sysstat 
    screen atop rsync znapzend
    (emacsWithPackages (p: with p; [
       column-marker nyan-mode smex ein js2-mode js3-mode
       multiple-cursors flyspell-lazy yasnippet buffer-move helm
       color-theme flycheck magit nix-mode gradle-mode lua-mode
    ]))
  ];
  programs.zsh.enable = true;
  programs.mosh.enable = true;
  programs.nano.nanorc = ''
    set nowrap
  '';
  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;

  # Workaround for inpure's server.
  networking.extraHosts = ''
    0.0.0.0 files.inpureprojects.info
  '';
}
