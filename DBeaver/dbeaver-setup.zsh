docker run -d \
        -p 8978:8978 \
        --name cloudbeaver \
        --restart=unless-stopped \
        -v cloudbeaver_data:/opt/cloudbeaver/workspace \
        dbeaver/cloudbeaver:26.0.1
