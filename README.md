

## Tasks

### build

```bash
nixos-rebuild build-vm --flake ".#node-1"
nixos-rebuild build-vm --flake ".#node-2"
nixos-rebuild build-vm --flake ".#node-3"
```

### create-bridge

Creates a bridge network under `192.168.10.*` for nodes to connect using.

```bash
sudo ip link add br0 type bridge 
sudo ip addr add 192.168.10.1/24 dev br0
sudo ip link set br0 up
printf "allow br0\n" | sudo tee -a /etc/qemu/bridge.conf
```
