if ! docker images windows-local -q | grep -q .; then
    echo "Image not found locally. Building..."
    docker build -t windows-local ..
else
    echo "Image found locally. Skipping build."
fi

docker compose -f ../compose.yml up

# Wait for the VM to start up
while true; do
  response=$(curl --write-out '%{http_code}' --silent --output /dev/null localhost:5000/probe)
  if [ $response -eq 200 ]; then
    break
  fi
  echo "Waiting for a response from the computer control server. When first building the VM storage folder this can take a while..."
  sleep 5
done

echo "VM + server is up and running!"