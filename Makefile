all: push

PREFIX=index.boxlinker.com/boxlinker

IMAGE_EMAIL=email-server
IMAGE_EMAIL_TAG=latest

rabbitmq:
	docker rm -f boxlinker-email-rabbitmq || true
	docker run -d --name boxlinker-email-rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management

build:
	cd cmd/email && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-w' -o email
	docker build -t ${IMAGE_ALIYUN_PREFIX}/${IMAGE_EMAIL}:${IMAGE_EMAIL_TAG} -f Dockerfile.email .

push: build
	docker push ${IMAGE_ALIYUN_PREFIX}/${IMAGE_EMAIL}:${IMAGE_EMAIL_TAG}
