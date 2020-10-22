FROM ubuntu:18.04
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

RUN cd /SOFT
RUN wget https://github.com/ebiggers/libdeflate/archive/v1.6.tar.gz \
&& tar -zxvf v1.6.tar.gz \
&& cd libdeflate-1.6 \
&& make prefix=/SOFT install \
&& make install

RUN cd /SOFT
RUN wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2 \
&& tar -vxjf htslib-1.10.2.tar.bz2 \
&& cd htslib-1.10.2 \
&& autoheader \
&& autoconf \
&& ./configure --with-libdeflate-1.6=/SOFT --prefix=/SOFT \
&& make \
&& make install

RUN cd /SOFT
ADD wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 .
RUN tar -vxjf samtools-1.10.tar.bz2 \
&& cd samtools-1.10 \
&& ./configure --with-htslib-1.10.2=/SOFT --prefix=/SOFT \
&& make \
&& make install

RUN cd /SOFT \
&& git clone https://github.com/gt1/libmaus2.git 
RUN cd libmaus2 \
&& libtoolize \
&& aclocal \
&& autoheader \
&& automake --force-missing --add-missing\
&& autoconf \
&& ./configure --prefix=/SOFT \
&& make \
&& make install

RUN cd /SOFT \
&& git clone https://github.com/gt1/biobambam2.git 
RUN cd biobambam2 \
&& autoreconf -i -f \
&& ./configure --with-libmaus2=/SOFT --prefix=/SOFT \
&& make install
