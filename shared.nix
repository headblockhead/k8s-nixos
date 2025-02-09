{ sshkeys, ... }:
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
  };

  users.users.root = {
    initialPassword = "root";
    openssh.authorizedKeys.keys = sshkeys;
  };

  #services.kubernetes = {
  #enable = true;
  #};
}
