DOCKER_SSH_KEY := $(shell cat ~/.ssh/id_rsa.pub)
NODE_IP := 172.53.0.10
NODE_NAME := balancer-test
NETWORK := balancer
SUBNET := 172.53.0.0/16
USER := $(or ${user},${user},root)
ENV := $(or ${env},${env},local)
INVENTORY := inventories/$(ENV)

.PHONY : test

network-create:
	docker network create --subnet=$(SUBNET) $(NETWORK) || true

network-remove:
	docker network rm $(NETWORK) || true

server:
	make network-create
	docker run --net $(NETWORK) --ip $(NODE_IP) --name $(NODE_NAME) -itd -P -e SSH_KEY="$(DOCKER_SSH_KEY)" gurkalov/ubuntu-ssh:bionic
	sleep 1
	ssh-keyscan -t rsa -H $(NODE_IP) >> ~/.ssh/known_hosts

down:
	docker rm -f $(NODE_NAME) || true
	ssh-keygen -f ~/.ssh/known_hosts -R $(NODE_IP)
	make network-remove

setup:
	ansible-playbook -i $(INVENTORY) -u $(USER) bootstrap.yml
	ansible-playbook -i $(INVENTORY) -u $(USER) server.yml

reboot:
	make down
	make server
	make setup
