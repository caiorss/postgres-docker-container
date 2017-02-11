all: image 

IMAGE=alpine-db

# Rule to build the docker image
image:
	docker build -t $(IMAGE) -f Dockerfile .

# Mount container /data to current ./data directory
run:
	mkdir -p ./data 
	docker run -it -v $(shell pwd)/data:/data -p 127.0.0.1:5432:5432 $(IMAGE)

# Used for debugging
debug:
	docker run -it -v $(shell pwd)/data:/data -p 127.0.0.1:5432:5432 --entrypoint=sh $(IMAGE)

clean:
	# Delete all containers
	rm -rf data 
	docker rm $(shell docker ps -a -q)
	docker rmi $(IMAGE):latest
