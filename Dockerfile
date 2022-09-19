FROM rockylinux:8
COPY tmp/bazelisk-linux-amd64 rockylinux:/usr/local/bin/bazelisk
COPY tmp/ModelSimSetup-20.1.1.720-linux.run rockylinux:/tmp/
RUN dnf group install -y "Development Tools" \
CMD ["/usr/sbin/init"]