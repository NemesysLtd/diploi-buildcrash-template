#!/bin/sh

# Perform tasks at controller pod startup
echo "Runonce started";

cd /app;

# Seems that this is first run in devel instance
# Intialize persistant storage
if [ ! "$(ls -A /app)" ]; then
  
  echo "Empty /app, assuming development instance setup was intended"
  #tar zxf /var/lib/diploi-app.tar.gz  -C /
  mkdir -p /root-persist/.vscode-server;
  touch /root-persist/.bash_history;
  touch /root-persist/.gitconfig;

  # TODO: HOW IS THIS SUPPOSED TO HAPPEN, AND WHERE ARE THE CREDENTIALS COMING FROM ?
  #git init;
  #git remote add --fetch origin $REPOSITORY_URL;
  #git checkout -f $REPOSITORY_BRANCH;
  #git remote set-url origin "$REPOSITORY_URL";
  #git config --global user.email "$GIT_USER_EMAIL";
  #git config --global user.name "$GIT_USER_NAME";

  npm install;

fi

# Update internal ca certificate
update-ca-certificates

# Insert accepted ssh key(s)
cat /etc/ssh/internal_ssh_host_rsa.pub >> /root/.ssh/authorized_keys;

# Make all special env variables available in ssh also (ssh will wipe out env by default)
env >> /etc/environment

supervisorctl start core

echo "Runonce done";

exit 0;