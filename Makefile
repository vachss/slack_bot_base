
IMAGE=slack-bot
CONTAINER=slack-bot


.PHONY: env-copy build rm run start logs

env-copy:
	cp  envfile.txt.tmp envfile.txt

build:
	docker build -t ${IMAGE} .

rm:
	docker rm -f ${CONTAINER}

run:	
	docker run --rm -it \
		--name ${CONTAINER} \
	  	--env-file envfile.txt \
 	  	${IMAGE}

start:
	docker run --rm -itd \
		--name ${CONTAINER} ${IMAGE} \
		--env-file envfile.txt

logs:
	docker logs -f ${CONTAINER}
