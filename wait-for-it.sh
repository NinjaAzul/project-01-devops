#!/bin/bash
# wait-for-it.sh

# Function to check if the database server is up
wait_for() {
  host="$1"
  port="$2"
  timeout=60  # Timeout in seconds

  echo "Waiting for $host:$port..."

  # Wait for the database to become available
  while ! nc -z "$host" "$port"; do
    timeout=$((timeout - 1))
    if [ "$timeout" -le 0 ]; then
      echo "Timed out waiting for $host:$port"
      exit 1
    fi
    sleep 1
  done

  echo "$host:$port is available!"
}

# Call the wait_for function with the MySQL service details
wait_for "$1" "$2"
