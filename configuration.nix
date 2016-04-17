# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let sshKeys = {
  svein = [ "cert-authority ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1YduKCwNp6O92ZedMZycjdDJNmBAY1zyaRBramnXsjBG0d75c37KXoaGPfdcGSsLJ9fxyv+CONsMj1c/sukTiLXMu0Rln62XeWo0dncX4FRXhJ7ShRdTFKwt0Kx5zzpBjTjw1ZOof3gGQVumLQKM9LCjTSFYSWyjPSxDHiV88dL1jt03qp0L3L8GjXwF5onUe3yun0+Cqj9CSVeN+I0cYprlpPucpCWIsrgclYHEcPg67UN3RVwxH/FV+sGAerJyoJFo7/Qu9MoTPP+eRFH8yGuoPforZPZTxUFIjkH2bYMozo1kcf3RQJfrKTTMa1mDfil9THeWP6E+iADSBDh4HLWcEkd3kGFuY5fhaRVFABFCqDsS7PXho+qg34PKfjn/2yuSwA4t4DPU6/T7JuF2rZs+WQX2I45WVvhtk43GNTk4dQTyfcxz9erryEDWVVxsrYoUQnSOVtooz/nJN4jK0xJNGoK0ZVwp/zlLhnrdrxO9GqYSABSTkedNuIoPrxDda0n8kBCtTryOPZzYBmBg6moLy9MCh7Q3TuFJMtMHLIlm3GChXeMwlWm2cYPu0vu8//HLhiOg9XIeLbLaFmOZA2i3TzksoevuNUMr+jXReVUGqcVoeejwz4ajII+swIgbUMWPIUaz4YDjtjG58B6N8r1OaeKFG/KMA6joubAuSPQ== svein@tsugumi" ];
  bloxgate = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkkA8U0Mw14OM+FUKLDaK3CmZtZyyQS7hBcMcXAUpvzldCJJXN59JDMnrEEvdQKPwaaRb6uWPOet4uE+C2RmB+MxpHvQYqZdbgo743HiacXtkuqi/85NyEOATCapJt0vpYYx9kqi8kyp5liiLcr3TbzDKAf3JJqG671/ZMUNlZvUh3tHD7An3mrEHSl7Zh2EETKuimpEbtO5cVikhFWndwugVmKsCMLwpaMcRGuAnuVGvuoD0XEz8X8W9k/+FM2lott4mAg8npo+ZXhbKZXil3uuUc8ln8loCwpZvg+CzdehWr/JcClofwOfUrLwO7EdvIu6Mu3c5pe0utubWuQgGZw== bloxgate-new-2016"
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAy/+H1vDZGfsRQJJkZJXDSRUAoQsw+K8P8nJj2CKugl+vw0+un2DPDJRi4GszqC5jkjKVNFHQxKtUZGMGBq8IzxXVudgdMQ0MYoQLxi563UMuPJ+94yuYvUZZ4lCzsq7lUZ6StwfoygQ/P2l6mVXhyCib7CYgS2ubstOn6H9A5UFR4FtZus7IGtpdUzMjzbjs8LQpS+Vr4Ju9cgGGmcKGWV3llz9zq+UDPSP2MZs3phvfo0nPSHTYD6m8tH7lGw945ZTrOj6z5LaHSZZuXqX9NxgdB7WiSYru9iZQVU7wDfZmnkeQ1X3IQBMI+LlqN9YqP6MjAjmQDv3FpmjFY3dQtQ== east-key"
  ];
  darqen27 = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfVJLC3cT5YPuwzvFF1BVLXod5v8q+zgaroAuMpUhZ9vML/R4c8+6Y9td5k7s2FAOfnKVCMrrYAzJWMReyqvUCsg1ZZViRhJtV2q5G66K69wdgXaacgD89S/p51ek4HsqzgwfeUtknDcwJJ9ZlTRhdVLmTc06mtChMC0QO3b5gUVM6hXS7lZivlql+SXOe3KaMNABlUpOMbEzcArSzde5suJyH2fc8OLBf1bhEt6xBaxQykNs1HJshu1UHjwGVCOkTFvQ51ohZbFdNHM2B1Pr1QF08ad9kCflWGjnXpBgXMwEpzLv4P1wOaRaFJn1bQjtTVGgyFxyEhjMJer5nexmA5rLTS9yKYlJ85nwJ6fmKWq3lcMkAmDlSXCbR047N6p5n4gBHnPcoBSfGgoX1RvsYdFW2Fa+lYyjJj40cWdaaCP0NfD7oAg08G3For/eaUUjJz1wtwFtaFEFyEu8hbll5MnOEosLcC5aa24Av7Fxz7P5YDVvPKUNn5HEsgxQf8X4pnUC69irdWvxoNsY5UeHj0R4YBKVHr9kvYPoeGr+5mftLtSeqzHHR5B7jaUL1kCsgu7Z/ATmoetaLWuQ63ToPF7a9P5QhC0K2dzmkXWWnmPr65cqy+h9YgyOQK3tMciOQKPQ3VSVTWUoovkJ/z9+Ns+KV2vQldI/VYfyjXTdgPw== darqen27@icloud.com" ];
  jmc = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZHmzn8nW1NUliqqB+4db2hV0jS4A7RrZ+2/QcLwsC2 jmc@clockwerk" ];
  kim = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA3j9muBMkqIAQ8BLBK5Ki4I1l2gg//Yt/YLmZd6nAaqYO4OeZ50k7x4F1OFRnyWScDqb4C5XggG8FaBQVe5RfP43sKDFx6F9En/zPB0JwbWT7iVXlZHFLLqqZ+vzrEmEYexQSwftpR1neKWb39fZjOcZTvd7Tk3sGNbnr/0LMYW0= kim@localhost" ];
  buizerd = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhD/TX8mV0yCbuVsSE8Nno9YLBIMccUKmmEK4Ps1z77D+mi9F6HeaLFJ9FGIvhZ1BVChCJrNTNsTSqRcHLoDye3IsQa080mwhK2hRYPpKPhpa8/Y1zXP6bk6oePVeZDHR1tMgkRJzM/8kOpgNKRKIcdtFU7KWvCWywAeLi8BjrLE3fHU1a2I3ZrT4FUintgjtYVPD7p3m7AEsx4nvqOCxHqlt04i175bwvQ4HVgFzNYgQX9oQw4NgPfDsCCNXkDcVBwZNakUu8q9guHbjWO+1IXvUwfTUEk3pRpbM3glbWzba2PXJA+xM4/NYhZbfXqsXY8vMOmkC0Z54gVEN07s8lw== buizerd@localhost" ]
  luke = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEClqIZgCTdObRDyG/0x+/72Ugbv1tqDjBIdmWbq4htd9I4WP2SWMh5r73L0DUVqs6HYS2JusFN8NSFDKEIr19LPuirrmq/TcdJBeEN25IMZSs2xId5gjhxxp/NloNyh6tQ4ketpi8cyWz2KqHX5wHjk52k2QOQ461jY/qZJ1eqDkwXA1Fxm0CbJw6HkfFhDLfEffsev2Duei/3M7joy5NxATZTeKZ/BG9yCEG9/oDsR3i3PUssMtZ2D98bLqTpU0i+WuSXZDZHZTd8nRv6f7ZndFGCldoQcSc4g/QH7qP40xjzN2jVeolQ5dI8cAhb1JeykRURskcA9GPkCb4HhBRHHuPN+w1rEbFSV1APsxjOV5T2628om78VX37cwrFT/lP6HP9f31B6oXu9hUTGNRnSI6bxKAF3TmqWsZgffHZ84wInW2sGV4lIAYKiMbnd/DanxsIkqbzWHigAmj04tSi3nbB6Jm+qtLg0TPkn29KFQW7kCwAZ7qKTmaWocbzWtyvA8Y1TNlzMJfT0vQ9dRh3onvPVLZwcVI/4dUFrGhJGREHJJ/Po1ZFry3ugE7rJ5FplrVC4AmJLWliVXacDvn+zbwIZHxbzUY/+xuPphvSq+kXoi6yjxTSYRnm1Xl6MAHF817kMypE+DYafCItxvJHklAdDc5zoXQ6p9I8BrTevsAU= castone22@gmail.com" ];
  
};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Various Minecraft-relevant jobs.
      ./minecraft.nix
    ];

  ## Boot ##
  boot.supportedFilesystems = [ "zfs" ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  # Emergency shell in case of failure.
  boot.initrd.network.enable = true;
  boot.initrd.network.ssh.enable = true;
  boot.initrd.network.ssh.authorizedKeys = sshKeys.svein;
  # Start up if at all possible.
  systemd.enableEmergencyMode = false;

  boot.cleanTmpDir = true;

  ## Networking ##
  networking.hostName = "madoka.brage.info";
  networking.hostId = "f7fcf93e";
  networking.defaultGateway = "148.251.151.193";
  # Doesn't work due to missing interface specification.
  #networking.defaultGateway6 = "fe80::1";
  networking.localCommands = ''
    /run/current-system/sw/bin/route -6 add default gw fe80::1 dev enp2s0
  '';
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.interfaces.enp2s0 = {
    ip4 = [{
      address = "148.251.151.200";
      prefixLength = 27;
    }];
    ip6 = [{
      address = "2a01:4f8:210:50c7::2";
      prefixLength = 64;
    }];
  };
  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 80 443 25565 4000 12345 ];
  };

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
  services.zfs.autoSnapshot.enable = true;
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
    openssh.authorizedKeys.keys = builtins.concatLists (lib.attrValues sshKeys);
  };
  users.extraUsers.bloxgate = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "wheel" ];
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
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = sshKeys.darqen27;
  };
  users.extraUsers.david = {
    isNormalUser = true; 
    uid = 1005;
  };
  users.extraUsers.jmc = {
    isNormalUser = true; 
    uid = 1003;
    extraGroups = [ "wheel" ];
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
    extraGroups = [ "wheel" ];
  };
  users.extraUsers.simplynoire = {
    isNormalUser = true; 
    uid = 1009;
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
        "promdash.brage.info" = null;
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
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "zfs";


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  ## Software ##
  system.autoUpgrade.enable = true;
  nix.extraOptions = "auto-optimise-store = true";
  nix.gc.automatic = true;
  nix.gc.dates = "Thu 03:15";
  nix.gc.options = "--delete-older-than 14d";
  environment.systemPackages = with pkgs; [
    tcpdump psmisc atop gdb stack wget file zip mosh irssi links screen telnet unison
    git mutt openjdk unzip imagemagick parallel moreutils vim nix-repl whois
    znc bsdgames shared_mime_info
    prometheus prometheus-node-exporter prometheus-alertmanager prometheus-nginx-exporter
  ];
  programs.zsh.enable = true;

  # Workaround for inpure's server.
  networking.extraHosts = ''
    0.0.0.0 files.inpureprojects.info
  '';
}
