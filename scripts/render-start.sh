#!/bin/sh
set -e

# Extract DB details from connection string if available
# Format: postgres://user:password@host:port/database
if [ -n "$DB_CONNECTION_STRING" ]; then
    echo "Parsing database connection string..."

    # Remove protocol
    temp="${DB_CONNECTION_STRING#*://}"

    # Extract user:password
    creds="${temp%@*}"
    export DB_POSTGRESDB_USER="${creds%%:*}"
    export DB_POSTGRESDB_PASSWORD="${creds#*:}"

    # Extract host:port/database
    rest="${temp#*@}"

    # Extract host:port
    hostport="${rest%%/*}"
    export DB_POSTGRESDB_HOST="${hostport%%:*}"
    export DB_POSTGRESDB_PORT="${hostport#*:}"

    # Extract database
    export DB_POSTGRESDB_DATABASE="${rest#*/}"

    echo "Database configuration set from connection string."
fi

# Execute the passed command
exec "$@"
