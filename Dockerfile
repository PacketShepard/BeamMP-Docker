FROM debian:10 as builder

MAINTAINER PacketShepard

RUN mkdir /beammp

WORKDIR /beammp

RUN printf "deb http://deb.debian.org/debian buster-backports main\n" > /etc/apt/sources.list.d/buster-backports.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    make \
    cmake \
    g++ \
    liblua5.3 \
    libz-dev \
    rapidjson-dev \
    libcurl4-openssl-dev \
    libboost1.71-all-dev \
    libssl-dev \
    git \
    curl \
    ca-certificates && \
    git clone --depth 1 --branch master https://github.com/BeamMP/BeamMP-Server.git BeamMP-Server 2>/dev/null

WORKDIR /beammp/BeamMP-Server

RUN cmake . && make

FROM debian:10

RUN mkdir /beammp

WORKDIR /beammp

RUN printf "deb http://deb.debian.org/debian buster-backports main\n" > /etc/apt/sources.list.d/buster-backports.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    liblua5.3 \
    libz-dev \
    rapidjson-dev \
    libboost-system1.71.0 \
    libboost-thread1.71.0 \
    libcurl4-openssl-dev && \
    apt-get clean

COPY --from=builder /beammp/BeamMP-Server/BeamMP-Server .

COPY entrypoint.sh .

ENV \
     TZ="America/New_York" \
     Debug="false" \
     Private="true" \
     Port="30814" \
     Cars="1" \
     MaxPlayers="10" \
     Map="/levels/gridmap/info.json" \
     Name="BeamMP New Server" \
     Desc="BeamMP Default Description" \
     use="Resources" \
     AuthKey=""

EXPOSE 30814
CMD ["./entrypoint.sh" ]
