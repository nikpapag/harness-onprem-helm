FROM harness/delegate:latest
RUN apt-get update && apt-get install -y curl git unzip
RUN mkdir ~/.ssh
RUN chmod 600 ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN chmod 600 ~/.ssh/known_hosts
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN ln -s ~/.tfenv/bin/* /usr/bin
RUN TERRAFORM_VERSIONS="1.2.1 1.2.2 1.2.3" \
    sh -c "for version in \$TERRAFORM_VERSIONS; do tfenv install \$version; done"
RUN echo 1.2.3 > ~/.tfenv/version
RUN tfenv list

