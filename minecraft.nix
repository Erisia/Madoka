{ config, lib, pkgs, ... }:

{

  systemd.services.restart-erisia = {
    description = "Restart Erisia (by stopping it)";
    startAt = "*-*-* 06:00";

    script = "source /etc/profile; exec /home/minecraft/erisia/stop.sh";
    serviceConfig.User = "minecraft";
  };

    

}
