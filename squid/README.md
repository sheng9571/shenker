# Squid (Proxy Server) in Docker

When the container is starting up, it will set username/password which loaded by [sec_file](https://github.com/sheng9571/shenker/blob/master/squid/sec_file) via [gen_auth.py](https://github.com/sheng9571/shenker/blob/master/squid/gen_auth.py) into squid htpasswd file.

When clients request to access squid service, squid service will recognize it's ip address. If the ip address is in our [white list](https://github.com/sheng9571/shenker/blob/master/squid/ip_white_list), and the squid service will ask clients for authentication.

### Usage:
#### Start Container:
```
docker-compose up -d
```


#### The format belogs to ip_white_list (locate at */opt/data/ip_white_list* in container):
```
127.0.0.1
192.168.1.0/24
```

#### The format belogs to sec_file (locate at */opt/data/sec_file* in container):
```
test1
test1_passwd

user2
user2_passwd

name3
name3_passwd
```

### Some tool-kits in container：

#### Start Squid Service
```
# Inside the container
/usr/local/sbin/squid_start

# In host
docker exec -it [container_name] squid_start
```

#### Stop Squid Service
```
# Inside the container
/usr/local/sbin/squid_stop

# In host
docker exec -it [container_name] squid_stop
```

#### Restart Squid Service
```
# Inside the container
/usr/local/sbin/squid_restart

# In host
docker exec -it [container_name] squid_restart
```



##### SSL-Bump (HTTPS Sniffer)
*Not completed ...*
