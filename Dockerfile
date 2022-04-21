# Now comes the actual target image, which aims to be as small as possible.
FROM  registry.cn-hangzhou.aliyuncs.com/ipfs2021/ipfs-cluster:base
LABEL maintainer="Steven Allen <steven@stebalien.com>"

ENV IPFS_CLUSTER_PATH      /data/ipfs-cluster
ENV IPFS_CLUSTER_CONSENSUS crdt
ENV IPFS_CLUSTER_DATASTORE leveldb
ENV CLUSTER_SECRET c870f550ff1d9198723dc1927679b7b6683fc524bd98300b6a92c37666e2973f
EXPOSE 9094
EXPOSE 9095
EXPOSE 9096

# Get the ipfs binary, entrypoint script, and TLS CAs from the build container.
COPY  ./bin/ipfs-cluster-service /usr/local/bin/ipfs-cluster-service
COPY  ./bin/ipfs-cluster-ctl /usr/local/bin/ipfs-cluster-ctl
COPY  ./bin/ipfs-cluster-follow /usr/local/bin/ipfs-cluster-follow
COPY  ./docker/entrypoint.sh  /usr/local/bin/entrypoint.sh

VOLUME $IPFS_CLUSTER_PATH
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]

# Defaults for ipfs-cluster-service go here
CMD ["daemon"]
