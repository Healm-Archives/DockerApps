container_name="cloudbeaver"

start_container() {
        docker run -d \
                -p 8978:8978 \
                --name $container_name \
                --restart=unless-stopped \
                -v cloudbeaver_data:/opt/cloudbeaver/workspace \
                dbeaver/cloudbeaver:26.0.1
}

docker ps -a --format '{{.Names}}' \
        | grep $container_name \
        || (echo no container exist \
        && start_container)

docker ps --format '{{.Names}}' \
        | grep "$container_name" \
        || (echo container inactive \
        && docker start $container_name \
        && sleep 2.5) \
        && xdg-open http://localhost:8978

sleep 1200 \
&& docker stop $container_name

