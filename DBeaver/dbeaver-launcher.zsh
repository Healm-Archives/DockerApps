container_name="cloudbeaver"

docker ps --format '{{.Names}}' \
        | grep -q "$container_name" \
        || (echo no container \
        && docker start $container_name \
        && sleep 1.5) \
        && xdg-open http://localhost:8978

sleep 1200 \
&& docker stop $container_name

