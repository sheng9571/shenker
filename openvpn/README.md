# OpenVPN Server in Docker

When the container start, it will auto startup the OpenVPN server and create client config files automatically.
In default settings, OpenVPN server will **authenticate** the user when connecting the OpenVPN server.
You can customize your own settings in [docker-compose.yml](https://github.com/sheng9571/shenker/blob/master/openvpn/docker-compose.yml) file.
## Usage:
#### Start Container
```
docker-compose up -d
```

#### Generate account for user authetication
```
# the password is use sha1 hash function, you can use your own method to generate hashed password, or use the tool-kit in container.
docker exec -it sheng_openvpn gen_account.py user1 user1_password
```

Insert username and hashed password into **secret** file which locate at **/opt/secret** in container. ( or at **data/secret** which is on host, the same folder as docker-compose.yml )
#### secret file format
```
user1
hashed_user1_password


user2
hashed_user2_password


user3
hashed_user3_password


... and so on ...
```

#### Get client config file
> When container startup, wait for a minute ...
> You will get **client.tar.xz** in **data**(**locate at the same folder as docker-compose.yml**) folder.

#### show OpenVPN server log
```
docker exec -it sheng_openvpn cat /var/log/openvpn/openvpn.log
```

#### OpenVPN client connect to server
```
# on Linux
openvpn --config config_file

# on Windows
Use OpenVPN GUI to insert config_file and interactive with server
```


## Some tool-kits in container：
#### start OpenVPN server
```
# in container
openvpn_start

# in host
docker exec -it [container_name] openvpn_start
```
#### stop OpenVPN server
```
# in container
openvpn_stop

# in host
docker exec -it [container_name] openvpn_stop
```
#### restart OpenVPN server
```
# in container
openvpn_restart

# in host
docker exec -it [container_name] openvpn_restart
```
#### generate hashed password for OpenVPN user authentication
```
# in container
gen_account.py [username] [password]

# in host
docker exec -it [container_name] gen_account.py [username] [password]
```
#### EasyRSA settings
```
# in container
openvpn_setting [-e path/of/easyrsa] [-k path/of/openvpn/keydir]

# in host
docker exec -it [container_name] openvpn_setting [-e path/of/easyrsa] [-k path/of/openvpn/keydir]
```
#### OpenVPN server config file
```
# in container
gen_server_conf [-p protocal(tcp or udp)] [-n nat_address_segment] [-s path/of/secret/account/password/file] [-k path/of/openvpn/keydir] [-c path/of/openvpn/server/config/file]

# in host
docker exec -it [container_name] gen_server_conf [-p protocal(tcp or udp)] [-n nat_address_segment] [-s path/of/secret/account/password/file] [-k path/of/openvpn/keydir] [-c path/of/openvpn/server/config/file]
```
#### OpenVPN client config file
```
# in container
gen_client_conf [-r remote_ip] [-p remote_port] [-c path/of/openvpn/client/config]

# in host
docker exec -it [container_name] gen_client_conf [-r remote_ip] [-p remote_port] [-c path/of/openvpn/client/config]
```
#### Generate client config file (pack into tar.xz)
```
# in container
get_client_conf [-e path/of/easyrsa] [-k path/of/openvpn/keydir] [-r remote_ip] [-p remote_port] [-c path/of/openvpn/client/conf]

# in host
docker exec -it [container_name] get_client_conf [-e path/of/easyrsa] [-k path/of/openvpn/keydir] [-r remote_ip] [-p remote_port] [-c path/of/openvpn/client/conf]
```
