NM=$1
alias multipass='multipass.exe'

multipass launch --name ${NM} 22.04 --memory 2G --disk 8G --cpus 2
multipass exec  ${NM} -- sudo apt install avahi-daemon -y
multipass transfer install-docker.sh ${NM}:/home/ubuntu/install-docker.sh
multipass exec ${NM} -- sh -x /home/ubuntu/install-docker.sh
