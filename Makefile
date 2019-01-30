#! /bin/bash

MANIFEST=./manifest

all: deploy

deploy: export  OP=create
deploy:
	@kubectl ${OP} -f ${MANIFEST}/namespace.yaml
	@kubectl ${OP} -f ${MANIFEST}/default-backend.yaml
	@kubectl ${OP} -f ${MANIFEST}/configmap.yaml
	@kubectl ${OP} -f ${MANIFEST}/rbac.yaml
	@kubectl ${OP} -f ${MANIFEST}/tcp-services-configmap.yaml
	@kubectl ${OP} -f ${MANIFEST}/udp-services-configmap.yaml
	@kubectl ${OP} -f ${MANIFEST}/with-rbac.yaml

clean: export OP=delete
clean:
	-@kubectl ${OP} -f ${MANIFEST}/with-rbac.yaml
	-@kubectl ${OP} -f ${MANIFEST}/udp-services-configmap.yaml
	-@kubectl ${OP} -f ${MANIFEST}/tcp-services-configmap.yaml
	-@kubectl ${OP} -f ${MANIFEST}/rbac.yaml
	-@kubectl ${OP} -f ${MANIFEST}/configmap.yaml
	-@kubectl ${OP} -f ${MANIFEST}/default-backend.yaml
	-@kubectl ${OP} -f ${MANIFEST}/namespace.yaml
