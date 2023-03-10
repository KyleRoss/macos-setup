# Sets NODE_PATH environment variable to include more paths
WHOAMI=$(whoami)
export NODE_PATH="/usr/local/bin/node:/usr/local/lib/node_modules:$WHOAMI/lib/node_modules"

# Sets NODE_ENV to development
export NODE_ENV=development
