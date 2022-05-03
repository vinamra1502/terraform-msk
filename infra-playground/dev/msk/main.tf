module "msk-cluster" {
  source  = "../../../terraform-module/msk/"

  cluster_name    = "kafka-dev"
  instance_type   = "kafka.t3.small"
  number_of_nodes = 3
  kafka_version   = "2.6.2"
  volume_size     = 40
  vpc_cidr          = "172.10.0.0/16"
  private_subnets_cidr  = ["172.10.16.0/20", "172.10.32.0/20", "172.10.48.0/20"]
  # extra_security_groups = ["sg-0d1be4440e4532e3d"]

  enhanced_monitoring = "PER_BROKER"

  s3_logs_bucket = "testingsbucket"
  s3_logs_prefix = "msklogs"

  prometheus_jmx_exporter  = false
  prometheus_node_exporter = false

  server_properties = {
    "auto.create.topics.enable" = "false"
    "default.replication.factor" = 3
    "delete.topic.enable" = "true"
    "min.insync.replicas" = "2"
    "num.io.threads" = "8"
    "num.network.threads" = "5"
    "num.partitions" = "1"
    "num.replica.fetchers" = "2"
    "socket.request.max.bytes" = "104857600"

}

  encryption_in_transit_client_broker = "TLS"

  tags = {
    Owner       = "Infra"
    Environment = "Dev"
    Component   = "MSK"
  }
}
