container_name="cloudbeaver"

run_container() {
        docker run -d \
                -p 8978:8978 \
                --name $container_name \
                --restart=unless-stopped \
                -v cloudbeaver_data:/opt/cloudbeaver/workspace \
                dbeaver/cloudbeaver:26.0.1
}

container_status=$(docker ps -a --filter "name=$container_name" \
        --format '{{.Status}}' \
        | awk '{print $1}' \
        | grep -E 'Up|Exited')

if [ -z "$container_status" ]; then
        echo "container doesnt exist"
        run_container
# elif [ $container_status = "Up" ]; then
else
        echo "container inactive" \
                && docker start $container_name
fi

sleep 2.5 \
&& xdg-open http://localhost:8978

sleep 1200 \
&& docker stop $container_name

