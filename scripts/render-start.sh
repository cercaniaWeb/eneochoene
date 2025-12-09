#!/bin/sh
set -e

# Extract DB password from connection string if available
if [ -n "$DB_CONNECTION_STRING" ]; then
    echo "Extracting database password from connection string..."
    # Format: postgres://user:password@host:port/database
    # Remove protocol
    temp="${DB_CONNECTION_STRING#*://}"
    # Remove everything after @ (gives user:password)
    creds="${temp%@*}"
    # Extract password (everything after first colon)
    export DB_POSTGRESDB_PASSWORD="${creds#*:}"
fi

# Execute the passed command
exec "$@"
