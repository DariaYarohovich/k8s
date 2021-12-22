docker build -t dmazaleuskaya/multi-client:latest -t dmazaleuskaya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmazaleuskaya/multi-server:latest -t dmazaleuskaya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmazaleuskaya/multi-worker:latest -t dmazaleuskaya/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmazaleuskaya/multi-client:latest
docker push dmazaleuskaya/multi-client:$SHA

docker push dmazaleuskaya/multi-server:latest
docker push dmazaleuskaya/multi-server:$SHA

docker push dmazaleuskaya/multi-worker:latest
docker push dmazaleuskaya/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dmazaleuskaya/multi-server:$SHA
kubectl set image deployments/client-deployment client=dmazaleuskaya/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dmazaleuskaya/multi-worker:$SHA

