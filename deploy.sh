docker build -t timmcnamaradev/multi-client:latest -t timmcnamaradev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timmcnamaradev/multi-server:latest -t timmcnamaradev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timmcnamaradev/multi-worker:latest -t timmcnamaradev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push timmcnamaradev/multi-client:latest
docker push timmcnamaradev/multi-server:latest
docker push timmcnamaradev/multi-worker:latest

docker push timmcnamaradev/multi-client:$SHA
docker push timmcnamaradev/multi-server:$SHA
docker push timmcnamaradev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=timmcnamaradev/multi-server:$SHA
kubectl set image deployments/client-deployment client=timmcnamaradev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=timmcnamaradev/multi-worker:$SHA