FROM starkandwayne/concourse

ENV NODE_VERSION 14.21.1

RUN set -ex \
	\
  apt-get install -y apt-transport-https && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y nodejs yarn && \
	rm -rf /var/lib/apt/lists/*
