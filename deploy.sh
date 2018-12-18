docker build -t spmonkey/multi-client:latest -t spmonkey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spmonkey/multi-server:latest -t spmonkey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t spmonkey/multi-worker:latest -t spmonkey/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push spmonkey/multi-client:latest
docker push spmonkey/multi-server:latest
docker push spmonkey/multi-worker:latest

docker push spmonkey/multi-client:$SHA
docker push spmonkey/multi-server:$SHA
docker push spmonkey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=spmonkey/multi-server:$SHA
kubectl set image deployments/client-deployments client=spmonkey/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=spmonkey/multi-worker:$SHA