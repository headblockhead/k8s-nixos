```bash
sudo ip link add br0 type bridge 
sudo ip addr add 192.168.10.1/24 dev br0
sudo ip link set br0 up
```
