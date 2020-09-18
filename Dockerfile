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

RUN cd ${HOME}/SOFT
ADD https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 .
RUN tar -vxjf samtools-1.10.tar.bz2 \
&& cd samtools-1.10 \
&& ./configure \
&& make \
&& make install

RUN cd ${HOME}/SOFT
RUN wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2 \
&& tar -vxjf htslib-1.10.2.tar.bz2 \
&& cd htslib-1.10.2 \
&& autoheader \
&& autoconf \
&& ./configure \
&& make \
&& make install

RUN cd ${HOME}/SOFT
RUN wget https://github.com/ebiggers/libdeflate/archive/v1.6.tar.gz \
&& tar -zxvf libdeflate-1.6.tar.gz \
&& cd libdeflate-1.6 \
&& make \
&7 make install

RUN cd ${HOME}/SOFT \
&& git clone https://github.com/gt1/libmaus2.git 
RUN cd libmaus2 \
&& libtoolize \
&& aclocal \
&& autoheader \
&& automake --force-missing --add-missing\
&& autoconf \
&& ./configure --prefix=${HOME}/SOFT/libmaus2 \
&& make \
&&make install

RUN cd ${HOME}/SOFT \
&& git clone https://github.com/gt1/biobambam2.git 
RUN cd biobambam2 \
&& autoreconf -i -f \
&& ./configure --with-libmaus2=${HOME}/SOFT/libmaus2 --prefix=${HOME}/SOFT/biobambam2 \
&& make install
