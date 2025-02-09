{ lib, pkgs, config, ... }:
{
  networking.hostName = "node-1";
  system.stateVersion = "24.11";
  virtualisation.qemu.networkingOptions = lib.mkForce [
    "-netdev bridge,id=vlan"
    "-device virtio-net-pci,netdev=vlan,mac=52:54:00:12:34:56"
  ];

  networking.interfaces.eth0.ipv4.addresses = [{
    address = "192.168.10.10";
    prefixLength = 24;
  }];

  services.k3s.clusterInit = true;
  services.k3s.serverAddr = lib.mkForce "";
}
