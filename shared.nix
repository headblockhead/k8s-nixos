{ pkgs, lib, sshkeys, ... }:
{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    openFirewall = true;
  };

  virtualisation = {
    cores = 2;
    memorySize = 4096;
    qemu = {
      guestAgent.enable = true;
    };
    diskSize = 10 * 1024 * 1024;
  };

  users.users.root = {
    password = "root";
    openssh.authorizedKeys.keys = sshkeys;
  };

  environment.systemPackages = with pkgs; [
    kubectl
    k9s
    #kubernetes
  ];

  networking.firewall.enable = lib.mkForce false;
  networking.useDHCP = false;
  networking.defaultGateway = "192.168.10.1";

  #  networking.firewall.allowedTCPPorts = [
  #6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
  #2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
  #2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  #];
  #networking.firewall.allowedUDPPorts = [
  #8472 # k3s, flannel: required if using multi-node for inter-node networking
  #];
}
