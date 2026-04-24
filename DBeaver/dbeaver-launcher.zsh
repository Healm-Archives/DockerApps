container_name="cloudbeaver"
# container_status=""

run_container() {
        docker run -d \
                -p 8978:8978 \
                --name $container_name \
                --restart=unless-stopped \
                -v cloudbeaver_data:/opt/cloudbeaver/workspace \
                dbeaver/cloudbeaver:26.0.1
}

# docker ps -a --filter "name=$container_name" \
# container_status() {
status=$(docker ps -a --filter "name=cloudbeaver" \
        --format '{{.Status}}' \
        | awk '{print $1}' \
        | grep -E 'Up|Exited')
# }

if [ -z "$status" ]; then
        echo "container doesnt exist"
        run_container
# elif [[ $status = "Up" ]]; then
else
        # echo "container exist with status: $status"
        echo "container inactive" \
                && docker start $container_name
fi

sleep 2.5 \
&& xdg-open http://localhost:8978

# docker ps -a --format '{{.Names}}' \
#         | grep $container_name \
#         || (echo no container exist \
#         && run_container)

# docker ps --format '{{.Names}}' \
#         | grep "$container_name" \
#         || (echo container inactive \
#         && docker start $container_name \
#         && sleep 2.5) \
#         && xdg-open http://localhost:8978

# sleep 1200 \
# && docker stop $container_name

