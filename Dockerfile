FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ARG WKDIR=/home/user
WORKDIR ${WKDIR}

RUN apt-get update && apt-get install -y \
        software-properties-common nano sudo \
    && sed -i 's/# set linenumbers/set linenumbers/g' /etc/nanorc \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY schema.fbs ${WKDIR}/
COPY flatc.tar.gz ${WKDIR}/

RUN tar -zxvf ${WKDIR}/flatc.tar.gz \
    && chmod +x ${WKDIR}/flatc \
    && rm ${WKDIR}/flatc.tar.gz

ENV USERNAME=user
RUN echo "root:root" | chpasswd \
    && adduser --disabled-password --gecos "" "${USERNAME}" \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
USER ${USERNAME}
