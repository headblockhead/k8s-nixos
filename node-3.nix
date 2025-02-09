{ lib, config, ... }:
{
  networking.hostName = "node-3";
  system.stateVersion = "24.11";
  virtualisation.qemu.networkingOptions = lib.mkForce [
    "-netdev bridge,id=vlan"
    "-device virtio-net-pci,netdev=vlan,mac=52:54:00:12:34:58"
  ];

  networking.interfaces.eth0.ipv4.addresses = [{
    address = "192.168.10.30";
    prefixLength = 24;
  }];
}
