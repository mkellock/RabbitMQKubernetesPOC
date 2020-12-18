FROM rabbitmq:3.8-management

RUN rabbitmq-plugins enable rabbitmq_federation --offline && \
    rabbitmq-plugins enable rabbitmq_management --offline && \
    rabbitmq-plugins enable rabbitmq_peer_discovery_k8s --offline && \
    rabbitmq-plugins enable rabbitmq_mqtt --offline && \
    rabbitmq-plugins enable rabbitmq_shovel --offline && \
    rabbitmq-plugins enable rabbitmq_shovel_management --offline && \
    rabbitmq-plugins enable rabbitmq_prometheus --offline

ENV RABBITMQ_CONFIG_FILE=/config/rabbitmq
ENV RABBITMQ_USE_LONGNAME=true

RUN mkdir /config
RUN chown rabbitmq: /config
RUN chmod -R u+rw /config
RUN echo 'loopback_users.guest = false\n\
listeners.tcp.default = 5672\n\
management.tcp.port = 15672\n\
mqtt.listeners.tcp.default = 1883\n\
mqtt.default_user = guest\n\
mqtt.default_pass = guest\n\
mqtt.allow_anonymous = true\n\
mqtt.vhost = /\n\
mqtt.exchange = amq.topic\n\
mqtt.subscription_ttl = 86400000\n\
mqtt.prefetch = 10\n\
mqtt.retained_message_store = rabbit_mqtt_retained_msg_store_ets\n\
cluster_formation.peer_discovery_backend  = rabbit_peer_discovery_k8s\n\
cluster_formation.k8s.host = kubernetes.default.svc.cluster.local\n\
cluster_formation.k8s.address_type = hostname\n\
cluster_formation.node_cleanup.only_log_warning = true\n\
vm_memory_high_watermark.absolute = 2147483648\n\
log.file.rotation.size = 5368709120' > /config/rabbitmq.conf

EXPOSE 1883 4369 5671 5672 8883 15671 15672 15691 15692 25672

USER rabbitmq