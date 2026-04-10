docker ps --format '{{.Names}}' \
        | grep -q "portainer" \
        || (echo no container \
        && docker start portainer \
        && sleep 1.5) \
        && xdg-open https://localhost:9443

sleep 600 \
&& docker stop portainer

