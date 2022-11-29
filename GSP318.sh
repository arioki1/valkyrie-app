
source <(gsutil cat gs://cloud-training/gsp318/marking/setup_marking_v2.sh)

git clone git@github.com:arioki1/valkyrie-app.git

cd valkyrie-app
docker build -t valkyrie-dev:0.0.3 .

~/marking/step1_v2.sh &

docker run -p 8080:8080 valkyrie-dev:0.0.3 &
~/marking/step2_v2.sh &


docker tag valkyrie-dev:0.0.3 & gcr.io/$GOOGLE_CLOUD_PROJECT/valkyrie-app:v0.0.1
docker push gcr.io/$GOOGLE_CLOUD_PROJECT/valkyrie-app:v0.0.1


gcloud container clusters create valkyrie-dev \
--num-nodes 2 \
--machine-type n1-standard-2 \
--zone us-west1-a 
--scopes "https://www.googleapis.com/auth/source.read_write,cloud-platform"


 cd ~/valkyrie-app/k8s/
sed -i s/PROJECT_ID/$GOOGLE_CLOUD_PROJECT/g deployment.yaml

kubectl create -f deployment.yaml
kubectl create -f service.yaml




