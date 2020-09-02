FROM ubuntu:18.04
WORKDIR /SOFT
RUN sudo apt-get update
RUN sudo apt-get install gcc
RUN sudo apt-get install make
RUN sudo apt-get install libbz2-dev
RUN sudo apt-get install zlib1g-dev
RUN sudo apt-get install libncurses5-dev 
RUN sudo apt-get install libncursesw5-dev
RUN sudo apt-get install liblzma-dev
RUN https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
RUN tar -vxjf samtools-1.9.tar.bz2 && cd samtools-1.10
RUN ./configure && make && make install
ADD https://gitlab.com/german.tischler/libmaus2/-/archive/2.0.749-release-20200827093918/libmaus2-2.0.749-release-20200827093918.tar.bz2
RUN tar -vxjf libmaus2-2.0.749-release-20200827093918.tar.bz2 && cd libmaus2-2.0.749-release-20200827093918
RUN ./configure && make
