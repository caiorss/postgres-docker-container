all: docker 

docker:
	docker build -f Dockerfile -t alpine-db

run:
	docker run -it -v $(pwd)/data:/data -p 127.0.0.1:5432:5432 alpine-db

clean:
	docker rmi alpine-db 
