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
python3 easy-install.py deploy --email=admin@laahtech.com --sitename=em.laahtech.com --app=erpnext --version="laahtech-em" --http-port=8080 --no-ssl
python3 easy-install.py upgrade -n frappe --version="laahtech-em" --http-port=8080 --no-ssl

docker volume rm docker_sites docker_redis-queue-data  docker_logs docker_db-data

DB:
root
9ab61baaf

Site:
administrator
f41323268e9f
