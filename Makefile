all: image 

IMAGE=alpine-db

# Rule to build the docker image
image:
	docker build -t $(IMAGE) -f Dockerfile .

# Mount container /data to current ./data directory
run: 
	mkdir -p data 
	# mkdir -p ./data
	# chmod 777 data 
	docker run -it -v $(shell pwd)/data:/data -p 127.0.0.1:5432:5432 $(IMAGE)

dir:
	mkdir -p ./data
	# chmod 777 data 


# Used for debugging
debug:
	docker run -it -v $(shell pwd)/data:/data -p 127.0.0.1:5432:5432 --entrypoint=sh $(IMAGE)

clean:
	# Delete all containers
	# Delete the data directory 
	# rm -rf data
	sudo rm -rf data 
	# Remove all containers using the image that was built
	docker ps -a | grep $(IMAGE) | awk "{print $$1}" | xargs docker rm
	# docker rm $(shell docker ps -a -q)
	# Remove the docker image built 
	docker rmi $(IMAGE)
