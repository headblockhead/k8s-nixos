{ pkgs, config, lib, sshkeys, ... }:
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
  ];

  services.k3s = {
    enable = true;
    images = [
      (pkgs.dockerTools.pullImage {
        imageName = "registry.k8s.io/e2e-test-images/agnhost";
        imageDigest = "sha256:7e8bdd271312fd25fc5ff5a8f04727be84044eb3d7d8d03611972a6752e2e11e";
        sha256 = "sha256-mPe2of+y6XXTryVqVjW3XATgtVG1U/DxlKOWwM5JyWw=";
        finalImageTag = "2.39";
      })

      config.services.k3s.package.airgapImages
    ];

    role = "server";
    token = "token"; # Change Me!
    serverAddr = "https://192.168.10.10:6443";
  };

  networking.useDHCP = false;
  networking.defaultGateway = "192.168.10.1";

  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
}
