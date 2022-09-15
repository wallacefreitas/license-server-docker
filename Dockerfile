FROM ubuntu:14.04 AS stage1
RUN apt-get update && apt-get install -y \
    default-jre \
    libxss1 \
    libxkbcommon-x11-0 \
    libxcb-xinerama0 \
    libxdamage1 \
    libxslt-dev \
    lsb-release \
    lsof \
    wget \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY license-entrypoint.sh .

FROM stage1 as stage2
EXPOSE 5555
CMD ./license-entrypoint.sh