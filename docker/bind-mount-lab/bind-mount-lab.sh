# Create a Host Workspace and HTML File
mkdir -p ~/devops-learn/docker/bind-mount-lab && cd ~/devops-learn/docker/bind-mount-lab
cat << 'EOF' > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Bind Mount Lab</title>
</head>
<body>
    <h1>Version 1: Initial Host File</h1>
    <p>This file is sitting on the host machine, synced live into the container.</p>
</body>
</html>
EOF

# Launch the Container with a Bind Mount
docker run --rm -d -p 8080:80 -v $(pwd):/usr/share/nginx/html --name bind-nginx nginx:alpine

# Verify it can be accessed
curl http://localhost:8080

# Modify the Host File and Verify Instant Sync
cat << 'EOF' > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Bind Mount Lab</title>
</head>
<body>
    <h1>Version 2: Updated Live on the Host!</h1>
    <p>The container reflected this change instantly without a rebuild.</p>
</body>
</html>
EOF

# Verify that the update on index.html is reflected to the Bind Mount
curl http://localhost:8080
