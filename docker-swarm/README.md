ref: https://dev.to/mattdark/docker-swarm-with-virtual-machines-using-multipass-39b0


## Create Virtual Machines

cf scripts :
- [init-instance.sh](./init-instance.sh)
- [install-docker.sh](install-docker.sh)

```sh
# create the manager node:
$ sh -x init-instance.sh manager
# Then, create two worker nodes:
$ sh -x init-instance.sh worker1
$ sh -x init-instance.sh worker2
```
> remark : add avahi-daemon for easy dns resolution

## Initialize the Swarm
```sh
# Initialized the swarm:
$ multipass exec manager -- docker swarm init

# You'll get the following output:
Swarm initialized: current node (fgjgd7qr4yg0dnlk8nurrqk9q) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5d9bj8wua4wy812hzl7vqc2r54yroy227i2oqkl27k3vzxdk7e-7na4j9souwf0s2yf6tmw5daiq 10.81.157.203:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instr
```

```sh
# Add the worker1 VM to the swarm as worker:
$ multipass exec worker1 -- docker swarm join --token SWMTKN-1-5d9bj8wua4wy812hzl7vqc2r54yroy227i2oqkl27k3vzxdk7e-7na4j9souwf0s2yf6tmw5daiq 10.81.157.203:2377
# Add the worker2 VM to the swarm as worker:
$ multipass exec worker2 -- docker swarm join --token SWMTKN-1-5d9bj8wua4wy812hzl7vqc2r54yroy227i2oqkl27k3vzxdk7e-7na4j9souwf0s2yf6tmw5daiq 10.81.157.203:2377

## Deploy a Service to the Swarm
```sh
deploy the first service, an Nginx server with three replicas.
$ multipass exec manager -- docker service create --name nginx --replicas 3 -p 80:80 nginx
```
* The docker service create command creates the service
* The --name flag is used to assing a name to the service, nginx
* The --replicas flag specifies the number of replicas
* The -p flag is used to open the port 80 in the host to receive and redirect requests to the port 80 in the container

```sh
# check the running services with the following command:
$ multipass exec manager -- docker service ls

# You'll get the following output:
ID             NAME      MODE         REPLICAS   IMAGE          PORTS
5rflc7yq4pyg   nginx     replicated   3/3        nginx:latest   *:80->80/tcp

# See which nodes are running the service, run the following command:
$ multipass exec manager -- docker service ps nginx

#You'll get the following output:
ID             NAME      IMAGE          NODE      DESIRED STATE   CURRENT STATE           ERROR     PORTS
ysp4p3ut581a   nginx.1   nginx:latest   worker1   Running         Running 6 minutes ago
7zozyfe4s8a5   nginx.2   nginx:latest   worker2   Running         Running 6 minutes ago
njdou1bmh4tm   nginx.3   nginx:latest   manager   Running         Running 6 minutes ago

```

```sh
# Display details about a service in an easily readable format, run:
$ multipass exec manager -- docker service inspect --pretty nginx
```

## Delete the service
```sh
to delete the service, just type:
$ multipass exec manager -- docker service rm nginx
```