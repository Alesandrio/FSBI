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

ADD https://vk.com/away.php?to=https%3A%2F%2Fgithub.com%2Fsamtools%2Fsamtools%2Freleases%2Fdownload%2F1.10%2Fsamtools-1.10.tar.bz2&cc_key= .
RUN tar -vxjf samtools-1.10.tar.bz2 \
&& cd samtools-1.10 \
&& ./configure \
&& make \
&& make install

ADD https://vk.com/away.php?to=https%3A%2F%2Fgitlab.com%2Fgerman.tischler%2Flibmaus2%2F-%2Farchive%2F2.0.749-release-20200827093918%2Flibmaus2-2.0.749-release-20200827093918.tar.bz2&cc_key= .
RUN tar -vxjf libmaus2-2.0.749-release-20200827093918.tar.bz2 && cd libmaus2-2.0.749-release-20200827093918
RUN autoreconf -i -f \
&& ./configure —prefix=${SOFT}/libmaus \
&& make install

ADD https://vk.com/away.php?to=https%3A%2F%2Fgithub.com%2Fgt1%2Fbiobambam2%2Farchive%2F2.0.89-release-20180518145034.tar.gz&cc_key= .
RUN tar -vxzf 2.0.89-release-20180518145034.tar.gz && cd 2.0.89-release-20180518145034
RUN autoreconf -i -f \
&& ./configure —with-libmaus2=${SOFT} —prefix=${SOFT}/biobambam2 \
&& make install
