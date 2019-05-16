# Build Docker Images
docker build -t upendranaik/multi-client:latest -t upendranaik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t upendranaik/multi-server:latest -t upendranaik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t upendranaik/multi-worker:latest -t upendranaik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to Docker Hub
docker push upendranaik/multi-client:latest
docker push upendranaik/multi-server:latest
docker push upendranaik/multi-worker:latest

docker push upendranaik/multi-client:$SHA
docker push upendranaik/multi-server:$SHA
docker push upendranaik/multi-worker:$SHA


# Apply all kubectl config files from k8s.
kubectl apply -f k8s

# Imperatively set latest images for each deployment
kubectl set image deployments/server-deployment server=upendranaik/multi-server:$SHA  
kubectl set image deployments/client-deployment client=upendranaik/multi-client:$SHA  
kubectl set image deployments/worker-deployment worker=upendranaik/multi-worker:$SHA  

