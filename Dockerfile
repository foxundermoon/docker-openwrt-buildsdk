FROM ubuntu:14.04

ENV OPENWRT_SDK_VERSION 17.01.4
ENV OPENWRT_SDK_ARCH cns3xxx
ENV OPENWRT_SDK_URL https://downloads.openwrt.org/releases/17.01.4/targets/cns3xxx/generic/lede-sdk-17.01.4-cns3xxx_gcc-5.4.0_musl-1.1.16_eabi.Linux-x86_64.tar.xz
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update;\
    apt-get install -y git-core subversion ccache build-essential gcc-multilib libssl-dev \
                       libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python &&\
    useradd -m openwrt &&\
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt &&\
    sudo -iu openwrt wget "${OPENWRT_SDK_URL}" &&\
    sudo -iu openwrt tar xf "$(basename ${OPENWRT_SDK_URL})" &&\
    sudo -iu openwrt rm -f "$(basename ${OPENWRT_SDK_URL})" &&\
    sudo -iu openwrt mv "$(basename ${OPENWRT_SDK_URL%%.tar.bz2})" openwrt &&\
    sudo -iu openwrt openwrt/scripts/feeds update

CMD sudo -iu openwrt bash
