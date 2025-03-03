# launch honcho prior to debugging 
honcho start \
    socketio \
    watch \
    schedule \
    worker

# launch honcho prior to debugging 
honcho start \
    socketio \
    schedule \
    worker \
    web

python installer.py -r "https://github.com/La-ah-Tech/frappe" -t "laahtech-em" -s development.localhost

docker exec -it erpnext-docker_devcontainer-frappe-1 bash

bench clear-cache

bench --site development.localhost clear-cache

bench --site development.localhost clear-website-cache

honcho start \
    socketio \
    watch \
    schedule \
    worker

bench --site development.localhost reinstall

wget https://raw.githubusercontent.com/La-ah-Tech/bench/laahtech-em/easy-install.py

python3 easy-install.py exec --project em

python3 easy-install.py deploy --project em \
    --email=admin@laahtech.com \
    --sitename=em.laahtech.com \
    --app erpnext \
    --app hrms \
    --http-port=8080 \
    --no-ssl

python3 easy-install.py deploy --project em \
    --email=admin@laahtech.com \
    --sitename=em.laahtech.com \
    --app erpnext \
    --app hrms \
    --version="laahtech-em" \
    --http-port=8080 \
    --no-ssl

python3 easy-install.py build --project em \
    --frappe-path "https://github.com/La-ah-Tech/frappe" \
    --frappe-branch "laahtech-em" \
    --tag=docker.io/library/custom-apps:latest \
	--image=docker.io/library/custom-apps \
	--deploy \
	--apps-json=apps.json \
    --email=admin@laahtech.com \
    --sitename=em.laahtech.com \
    --app erpnext \
    --app hrms \
    --version="laahtech-em" \
    --http-port=8080 \
    --no-ssl

docker.io/library/custom-apps:latest

python3 easy-install.py build \
    --project em \
	--image=docker.io/frappe/erpnext \
	--deploy \
	--apps-json=apps.json \
    --email=admin@laahtech.com \
    --sitename=em.laahtech.com \
    --app erpnext \
    --app hrms \
    --version="laahtech-em" \
    --http-port=8080 \
    --no-ssl


docker stop $(docker ps -q)
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)
docker system prune -af --volumes

python3 easy-install.py build \
    -n em \
	--tag=docker.io/laahtech/laahtech-em:laahtech-em \
	--image=docker.io/laahtech/laahtech-em \
	--deploy \
	--apps-json=apps.json \
    --email=admin@laahtech.com \
    --sitename=em.laahtech.com \
    --app erpnext \
    --app hrms \
    --version="laahtech-em" \
    --http-port=8080 \
    --no-ssl

rm /var/www/vhosts/laahtech.com/em-compose.yml 
rm /var/www/vhosts/laahtech.com/em.env

python3 easy-install.py upgrade -n em --version="laahtech-em" --http-port=8080 --no-ssl

docker volume rm docker_sites docker_redis-queue-data  docker_logs docker_db-data
docker volume rm em_sites em_redis-queue-data em_logs em_db-data

DB:
root
9ab61baaf

Site:
administrator
f41323268e9f
