FROM occlum/occlum:0.26.2-ubuntu18.04

WORKDIR /tmp
# Using customized own linux-sgx
RUN git clone -b sgx_2.15.1_for_occlum https://github.com/StanPlatinum/linux-sgx.git && \
    cd linux-sgx && \
    ./compile_and_install.sh no_mitigation USE_OPT_LIBS=3 && \
    echo 'source /opt/intel/sgxsdk/environment' >> /root/.bashrc  && \
    rm -rf /tmp/linux-sgx

# Download the Occlum source
WORKDIR /root
RUN git clone https://github.com/occlum/occlum.git && \
    cp -r /root/occlum/tools/toolchains/* /tmp/ && mkdir -p /opt/occlum/ && \
    cp /root/occlum/tools/docker/start_aesm.sh /opt/occlum/

## Re-install occlum
WORKDIR /root
SHELL ["/bin/bash", "-c"]
RUN cd occlum && \
    source /opt/intel/sgxsdk/environment && \
    make submodule && \
    OCCLUM_RELEASE_BUILD=1 make && \
    make install && \
    rm -rf /root/occlum
