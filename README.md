# openvpn-as
## 1. 简介
```Plain Text
CentOS7目录: OpenVPN-as-CentOS7平台rpm包
CentOS8目录: OpenVPN-as-CentOS8平台rpm包
docker目录: OpenVPN-as-docker版本及docker-compose文件
```
## 2. docker部署
### 2.1 使用docker-compose部署
```yaml
services:
  openvpn-as:
    image: tcpip6/openvpn-as:2.13-c7
    container_name: openvpn-as
    restart: unless-stopped
    privileged: true
    devices:
      - /dev/net/tun:/dev/net/tun
    #cap_add:
    #  - NET_ADMIN
    #  - SYS_MODULE
    volumes:
      - ./data:/openvpn
      - /etc/localtime:/etc/localtime
      - /etc/resolv.conf:/etc/resolv.conf
    ports:
      - 943:943
      - 9443:9443
      - 1194:1194/udp
```
### 2.2 状态
```Plain Text
看到日志输出如下即部署成功
   "service_status": {
     "api": "started",
     "auth": "started",
     "bridge": "started",
     "client_query": "started",
     "crl": "started",
     "daemon_pre": "started",
     "db_push": "started",
     "ip6tables_live": "started",
     "ip6tables_openvpn": "started",
     "iptables_api": "started",
     "iptables_live": "started",
     "iptables_openvpn": "started",
     "iptables_web": "started",
     "log": "started",
     "openvpn_0": "started",
     "openvpn_1": "started",
     "openvpn_2": "started",
     "openvpn_3": "started",
     "subscription": "started",
     "user": "started",
     "web": "started"
   }
 Server Agent started
 License Info {'concurrent_connections': 9999, 'apc': False}
```
### 2.3 设置管理员密码
```bash
docker exec -it openvpn-as sacli --user "openvpn" --new_pass "YouPassword" SetLocalPassword
```

## 3. 访问
```Plain Text
#用户页面及改密码（openvpn这个管理员账户也是在这里改密码）
https://ip:943/

#管理员后台
https://ip:943/admin/
```