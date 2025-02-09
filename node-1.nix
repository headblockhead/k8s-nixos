{ lib, config, ... }:
{
  networking.hostName = "node-1";
  system.stateVersion = "24.11";
  virtualisation.qemu.networkingOptions = lib.mkForce [
    "-nic user,id=cluster,ipv6=off,net=10.0.2.0/24,hostfwd=tcp:127.0.0.1:2010-:22,hostname=node-1,host=10.0.2.10"
  ];

  services.k3s = {
    enable = true;
    images = [ config.services.k3s.package.airgapImages ];
    role = "server";
    token = "TODO: changeme";
    clusterInit = true;
  };
}
