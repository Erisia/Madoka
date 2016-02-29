# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let sshKeys = {
  svein = [ "cert-authority ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1YduKCwNp6O92ZedMZycjdDJNmBAY1zyaRBramnXsjBG0d75c37KXoaGPfdcGSsLJ9fxyv+CONsMj1c/sukTiLXMu0Rln62XeWo0dncX4FRXhJ7ShRdTFKwt0Kx5zzpBjTjw1ZOof3gGQVumLQKM9LCjTSFYSWyjPSxDHiV88dL1jt03qp0L3L8GjXwF5onUe3yun0+Cqj9CSVeN+I0cYprlpPucpCWIsrgclYHEcPg67UN3RVwxH/FV+sGAerJyoJFo7/Qu9MoTPP+eRFH8yGuoPforZPZTxUFIjkH2bYMozo1kcf3RQJfrKTTMa1mDfil9THeWP6E+iADSBDh4HLWcEkd3kGFuY5fhaRVFABFCqDsS7PXho+qg34PKfjn/2yuSwA4t4DPU6/T7JuF2rZs+WQX2I45WVvhtk43GNTk4dQTyfcxz9erryEDWVVxsrYoUQnSOVtooz/nJN4jK0xJNGoK0ZVwp/zlLhnrdrxO9GqYSABSTkedNuIoPrxDda0n8kBCtTryOPZzYBmBg6moLy9MCh7Q3TuFJMtMHLIlm3GChXeMwlWm2cYPu0vu8//HLhiOg9XIeLbLaFmOZA2i3TzksoevuNUMr+jXReVUGqcVoeejwz4ajII+swIgbUMWPIUaz4YDjtjG58B6N8r1OaeKFG/KMA6joubAuSPQ== svein@tsugumi" ];
  bloxgate = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAwGYMczegAbbzmKRxF7GVDP5AfaAA0YzS6KDOm2Qzfy9S+Dd8Rc5jx7Q2JLadzhKlz7slfoaNpxejMKmVdgXOmeN6dc7xI9TiMR40Gv0q1KxnJsJIG3WJzK1HiAZefsFKLPX4eOb0Ip7/rMVT7XDkVjrqNmD2Fzz8lKItGKdRKo5gjUCkdSBfYwnuEnKQs56T3vUJnJ4e+p5IMBt8LIb2C3P+lCYS0eZPde1nLb0fXRxDsPytccZcgKXHUKrUuSNMNZm3Z1ZDzrSC5pagLKputTeO3AJq8SWSWp4Je/ZCMa8CwCS/1WBSsk6k2kWjyV+LhTwv7ibrOpo/VsI0zhYrOQ== bloxgate"
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAy/+H1vDZGfsRQJJkZJXDSRUAoQsw+K8P8nJj2CKugl+vw0+un2DPDJRi4GszqC5jkjKVNFHQxKtUZGMGBq8IzxXVudgdMQ0MYoQLxi563UMuPJ+94yuYvUZZ4lCzsq7lUZ6StwfoygQ/P2l6mVXhyCib7CYgS2ubstOn6H9A5UFR4FtZus7IGtpdUzMjzbjs8LQpS+Vr4Ju9cgGGmcKGWV3llz9zq+UDPSP2MZs3phvfo0nPSHTYD6m8tH7lGw945ZTrOj6z5LaHSZZuXqX9NxgdB7WiSYru9iZQVU7wDfZmnkeQ1X3IQBMI+LlqN9YqP6MjAjmQDv3FpmjFY3dQtQ== east-key"
  ];
  darqen27 = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfVJLC3cT5YPuwzvFF1BVLXod5v8q+zgaroAuMpUhZ9vML/R4c8+6Y9td5k7s2FAOfnKVCMrrYAzJWMReyqvUCsg1ZZViRhJtV2q5G66K69wdgXaacgD89S/p51ek4HsqzgwfeUtknDcwJJ9ZlTRhdVLmTc06mtChMC0QO3b5gUVM6hXS7lZivlql+SXOe3KaMNABlUpOMbEzcArSzde5suJyH2fc8OLBf1bhEt6xBaxQykNs1HJshu1UHjwGVCOkTFvQ51ohZbFdNHM2B1Pr1QF08ad9kCflWGjnXpBgXMwEpzLv4P1wOaRaFJn1bQjtTVGgyFxyEhjMJer5nexmA5rLTS9yKYlJ85nwJ6fmKWq3lcMkAmDlSXCbR047N6p5n4gBHnPcoBSfGgoX1RvsYdFW2Fa+lYyjJj40cWdaaCP0NfD7oAg08G3For/eaUUjJz1wtwFtaFEFyEu8hbll5MnOEosLcC5aa24Av7Fxz7P5YDVvPKUNn5HEsgxQf8X4pnUC69irdWvxoNsY5UeHj0R4YBKVHr9kvYPoeGr+5mftLtSeqzHHR5B7jaUL1kCsgu7Z/ATmoetaLWuQ63ToPF7a9P5QhC0K2dzmkXWWnmPr65cqy+h9YgyOQK3tMciOQKPQ3VSVTWUoovkJ/z9+Ns+KV2vQldI/VYfyjXTdgPw== darqen27@icloud.com" ];
  jmc = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZHmzn8nW1NUliqqB+4db2hV0jS4A7RrZ+2/QcLwsC2 jmc@clockwerk" ];
  kim = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA3j9muBMkqIAQ8BLBK5Ki4I1l2gg//Yt/YLmZd6nAaqYO4OeZ50k7x4F1OFRnyWScDqb4C5XggG8FaBQVe5RfP43sKDFx6F9En/zPB0JwbWT7iVXlZHFLLqqZ+vzrEmEYexQSwftpR1neKWb39fZjOcZTvd7Tk3sGNbnr/0LMYW0= kim@localhost" ];
  buizerd = [ "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhD/TX8mV0yCbuVsSE8Nno9YLBIMccUKmmEK4Ps1z77D+mi9F6HeaLFJ9FGIvhZ1BVChCJrNTNsTSqRcHLoDye3IsQa080mwhK2hRYPpKPhpa8/Y1zXP6bk6oePVeZDHR1tMgkRJzM/8kOpgNKRKIcdtFU7KWvCWywAeLi8BjrLE3fHU1a2I3ZrT4FUintgjtYVPD7p3m7AEsx4nvqOCxHqlt04i175bwvQ4HVgFzNYgQX9oQw4NgPfDsCCNXkDcVBwZNakUu8q9guHbjWO+1IXvUwfTUEk3pRpbM3glbWzba2PXJA+xM4/NYhZbfXqsXY8vMOmkC0Z54gVEN07s8lw== buizerd@localhost" ];
};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Boot ##
  boot.supportedFilesystems = [ "zfs" ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  # Emergency shell in case of failure.
  boot.initrd.network.ssh.enable = true;
  boot.initrd.network.ssh.authorizedKeys = sshKeys.svein;

  boot.cleanTmpDir = true;

  ## Networking ##
  networking.hostName = "madoka.brage.info";
  networking.hostId = "f7fcf93e";
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

  ## Email & cron ##
  services.cron.enable = true;
  services.cron.mailto = "svein";
  services.postfix.enable = true;

  ## Users ##
  users.extraUsers.svein = {
    isNormalUser = true;
    uid = 1004;
    extraGroups = [ "wheel" ];
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
      };
    };
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  ## Software ##
  system.autoUpgrade.enable = true;
  nix.extraOptions = "auto-optimise-store = true";
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";
  environment.systemPackages = with pkgs; [
    tcpdump psmisc atop gdb stack wget file zip mosh irssi links screen telnet unison
    gitAndTools.gitFull mutt jdk unzip imagemagick parallel moreutils vim nix-repl whois
    znc
    prometheus prometheus-node-exporter prometheus-alertmanager prometheus-nginx-exporter
  ];
}
