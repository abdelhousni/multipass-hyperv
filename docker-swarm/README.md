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

## Initialize the Swarm

## Deploy a Service to the Swarm

## Delete the service
