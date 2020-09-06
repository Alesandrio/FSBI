FROM ubuntu:18.04
RUN mkdir /SOFT
WORKDIR /SOFT
RUN sudo apt-get update \
sudo apt-get install gcc \
sudo apt-get install make \
sudo apt-get install libbz2-dev \
sudo apt-get install zlib1g-dev \
sudo apt-get install libncurses5-dev \
sudo apt-get install libncursesw5-dev \
sudo apt-get install liblzma-dev \
    && rm -rf /var/lib/apt/lists/*
ADD https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 \
/SOFT
RUN tar -vxjf samtools-1.10.tar.bz2 && cd samtools-1.10
RUN ./configure && make && make install
ADD https://gitlab.com/german.tischler/libmaus2/-/archive/2.0.749-release-20200827093918/libmaus2-2.0.749-release-20200827093918.tar.bz2 \
/SOFT
RUN tar -vxjf libmaus2-2.0.749-release-20200827093918.tar.bz2 && cd libmaus2-2.0.749-release-20200827093918
RUN autoreconf -i -f && ./configure --prefix=${SOFT}/libmaus && make install
ADD https://github.com/gt1/biobambam2/archive/2.0.89-release-20180518145034.tar.gz
RUN tar -vxzf 2.0.89-release-20180518145034.tar.gz && cd 2.0.89-release-20180518145034
RUN autoreconf -i -f && ./configure --with-libmaus2=${SOFT} \
	--prefix=${SOFT}/biobambam2 && make install
