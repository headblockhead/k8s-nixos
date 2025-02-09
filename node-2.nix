{ lib, config, ... }:
{
  networking.hostName = "node-1";
  system.stateVersion = "24.11";
  virtualisation.qemu.networkingOptions = lib.mkForce [
    "-nic user,id=cluster,ipv6=off,net=10.0.2.0/24,hostfwd=tcp:127.0.0.1:2020-:22,hostname=node-2,host=10.0.2.20"
  ];

  services.k3s = {
    enable = true;
    role = "server";
    token = "TODO: changeme";
    serverAddr = "https://10.0.2.10:6443";
  };
}
