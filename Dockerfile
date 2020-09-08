FROM ubuntu:18.04
RUN mkdir /SOFT
WORKDIR /SOFT

RUN apt-get -y update \
&& apt-get install -y make \
&& apt-get install -y gcc \
&& apt-get install -y make \
&& apt-get install -y libbz2-dev \
&& apt-get install -y zlib1g-dev \
&& apt-get install -y libncurses5-dev \
&& apt-get install -y libncursesw5-dev \
&& apt-get install -y liblzma-dev \
&& rm -rf /var/lib/apt/lists/*

ADD https://github.com/samtools/samtools/releases/downloa.. .
RUN tar -vxjf samtools-1.10.tar.bz2 \
&& cd samtools-1.10 \
&& ./configure \
&& make \
&& make install

ADD https://gitlab.com/german.tischler/libmaus2/-/archive.. .
RUN tar -vxjf libmaus2-2.0.749-release-20200827093918.tar.bz2 && cd libmaus2-2.0.749-release-20200827093918
RUN autoreconf -i -f \
&& ./configure —prefix=${SOFT}/libmaus \
&& make install

ADD https://github.com/gt1/biobambam2/archive/2.0.89-rele.. .
RUN tar -vxzf 2.0.89-release-20180518145034.tar.gz && cd 2.0.89-release-20180518145034
RUN autoreconf -i -f \
&& ./configure —with-libmaus2=${SOFT} —prefix=${SOFT}/biobambam2 \
&& make install
