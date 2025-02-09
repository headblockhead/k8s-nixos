{ lib, config, ... }:
{
  networking.hostName = "node-2";
  system.stateVersion = "24.11";
  virtualisation.qemu.networkingOptions = lib.mkForce [
    "-netdev bridge,id=vlan"
    "-device virtio-net-pci,netdev=vlan,mac=52:54:00:12:34:57"
  ];

  networking.interfaces.eth0.ipv4.addresses = [{
    address = "192.168.10.20";
    prefixLength = 24;
  }];
}
