#!/usr/bin/env bash

sudo yum -y update
sudo yum -y groupinstall "Development Tools"

#
# Install rbenv
# -------------------------------------------
if ! command -v rbenv > /dev/null; then

  RBENV_ROOT="${HOME}/.rbenv"

  PLUGINS=(
    "sstephenson/ruby-build"
    "sstephenson/rbenv-default-gems"
    "sstephenson/rbenv-gem-rehash"
    "rkh/rbenv-update"
  )

  # Install rbenv
  git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT

  # Install rbenv plugins
  for plugin in "${PLUGINS[@]}"; do

    KEY=${plugin%%/*}
    VALUE=${plugin#*/}

    git clone https://github.com/$KEY/$VALUE.git "${RBENV_ROOT}/plugins/$VALUE"

  done

# Add rbenv-default-gems
cat << EOF > "${RBENV_ROOT}/default-gems"
bundler
pry
ruby-debug-ide
debase
EOF

  # Add rbenv to PATH
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  source ~/.bash_profile

fi


