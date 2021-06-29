#
# Dockerfile for SRBMiner-Multi, https://github.com/hellcatz/luckpool
# see run.sh
#
FROM debian:buster-slim
RUN apt-get update && apt-get -y install wget xz-utils && \
    cd /opt && wget https://github.com/doktor83/SRBMiner-Multi/releases/download/0.7.3/SRBMiner-Multi-0-7-3-Linux.tar.xz && \
	tar xf SRBMiner-Multi-0-7-3-Linux.tar.xz && rm -rf /opt/SRBMiner-Multi-0-7-3-Linux.tar.xz && \
	apt-get -y purge xz-utils && apt-get -y autoremove --purge && apt-get -y clean && apt-get -y autoclean; rm -rf /var/lib/apt-get/lists/*
COPY entrypoint /opt/SRBMiner-Multi-0-7-3/
RUN chmod +x /opt/SRBMiner-Multi-0-7-3/entrypoint
# it needs a workdir spec in order to see the 'verus-solver' binary right next to it
WORKDIR "/opt/SRBMiner-Multi-0-7-3"
RUN ./SRBMiner-MULTI --disable-gpu --algorithm panthera --pool pool.scalaproject.io:3333 --wallet Ssy2Ceu2umdNYxHh799vEiApWhozLK5g9K4y8qR7mRXpPeaYNB8pgmJRxe9rgyNMVoSwKvnPs4r6ZVoreuYv3nkb9ADjTvBgJ9.GELAR --password xx2
ENTRYPOINT "./entrypoint"
# EOF
