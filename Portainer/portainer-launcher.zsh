container_name="portainer"

run_container() {
        docker run -d \
                -p 8000:8000 \
                -p 9443:9443 \
                --name portainer \
                --restart=unless-stopped \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v portainer_data:/data \
                portainer/portainer-ce:2.40.0-alpine
}

container_status=$(docker ps -a --filter "name=$container_name" \
        --format '{{.Status}}' \
        | awk '{print $1}' \
        | grep -q -E 'Up|Exited')

if [ -z "$container_status" ]; then
        echo "container doesnt exist"
        run_container
# elif [ $container_status = "Up" ]; then
else
        echo "container inactive" \
                && docker start $container_name
fi

sleep 1.5 \
&& xdg-open https://localhost:9443

sleep 1200 \
&& docker stop $container_name

