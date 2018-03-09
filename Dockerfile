FROM stevenrbrandt/science-base
USER root
RUN mkdir -p /usr/install
RUN chown jovyan /usr/install
RUN apt-get update
RUN apt-get install -y curl
RUN mkdir /model
RUN mkdir /work
RUN mkdir /project
RUN mkdir /project/singularity
RUN mkdir /project/singularity/bin
RUN mkdir /var/spool/torque
RUN chown jovyan /var/spool/torque
RUN chown jovyan /project
RUN chown jovyan /project/singularity
RUN chown jovyan /project/singularity/bin
RUN chown jovyan /model
RUN chown jovyan /work
USER jovyan

MAINTAINER Steven R. Brandt <sbrandt@cct.lsu.edu>
RUN cd /usr/install && \
     git clone https://github.com/fengyanshi/FUNWAVE-TVD && \
     cd FUNWAVE-TVD/src && \
     perl -p -i -e 's/FLAG_8 = -DCOUPLING/#$&/' Makefile && \
     make

WORKDIR /usr/install/FUNWAVE-TVD/src
RUN mkdir -p /home/jovyan/rundir
USER root
RUN mkdir -p /workdir
RUN touch /etc/ssh/ssh_known_hosts
USER jovyan
WORKDIR /home/jovyan/rundir
