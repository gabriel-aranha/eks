cluster_name_prefix = "eks"
cidr                = "192.168.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b","us-east-1c"]
node_groups = {
    default = {
        node_group_name          = "default"
        node_group_instance_type = "t2.micro"
        node_group_ami_type      = "BOTTLEROCKET_x86_64"
        desired_worker_nodes     = 1
        max_worker_nodes         = 1
        min_worker_nodes         = 1
        taints = []
    }
    argocd = {
        node_group_name          = "argocd"
        node_group_instance_type = "t2.small"
        node_group_ami_type      = "BOTTLEROCKET_x86_64"
        desired_worker_nodes     = 1
        max_worker_nodes         = 1
        min_worker_nodes         = 1
        taints = [
            {
                key    = "namespace"
                value  = "argocd"
                effect = "NO_SCHEDULE"
            }
        ]
    }
    prometheus = {
        node_group_name          = "prometheus"
        node_group_instance_type = "t2.small"
        node_group_ami_type      = "BOTTLEROCKET_x86_64"
        desired_worker_nodes     = 1
        max_worker_nodes         = 1
        min_worker_nodes         = 1
        taints = [
            {
                key    = "namespace"
                value  = "prometheus"
                effect = "NO_SCHEDULE"
            }
        ]
    }
    datadog = {
        node_group_name          = "datadog"
        node_group_instance_type = "t2.micro"
        node_group_ami_type      = "BOTTLEROCKET_x86_64"
        desired_worker_nodes     = 1
        max_worker_nodes         = 1
        min_worker_nodes         = 1
        taints = [
            {
                key    = "namespace"
                value  = "datadog"
                effect = "NO_SCHEDULE"
            }
        ]
    }
}
helm_charts = {
    argocd = {
        name       = "argocd"
        namespace  = "argocd"
        repository = "https://argoproj.github.io/argo-helm"
        chart      = "argo-cd"
        custom_overrides = []
        overrides = [
            {
                name = "controller.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "controller.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "controller.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "controller.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "controller.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "dex.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "dex.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "dex.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "dex.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "dex.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "redis.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "redis.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "redis.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "redis.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "redis.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "server.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "server.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "server.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "server.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "server.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "repoServer.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "repoServer.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "repoServer.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "repoServer.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "repoServer.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "applicationSet.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "applicationSet.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "applicationSet.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "applicationSet.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "applicationSet.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "notifications.nodeSelector.name"
                value = "argocd"
            },
            {
                name = "notifications.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "notifications.tolerations[0].value"
                value= "argocd"
            },
            {
                name = "notifications.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "notifications.tolerations[0].effect"
                value= "NoSchedule"
            }
        ]
    }
    prometheus = {
        name       = "prometheus"
        namespace  = "prometheus"
        repository = "https://prometheus-community.github.io/helm-charts"
        chart      = "prometheus"
        custom_overrides = []
        overrides = [
            {
                name = "alertmanager.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "alertmanager.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "alertmanager.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "alertmanager.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "alertmanager.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "configmapReload.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "configmapReload.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "configmapReload.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "configmapReload.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "configmapReload.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "nodeExporter.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "nodeExporter.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "nodeExporter.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "nodeExporter.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "nodeExporter.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "kubeStateMetrics.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "kubeStateMetrics.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "kubeStateMetrics.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "kubeStateMetrics.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "kubeStateMetrics.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "server.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "server.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "server.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "server.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "server.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "pushgateway.nodeSelector.name"
                value = "prometheus"
            },
            {
                name = "pushgateway.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "pushgateway.tolerations[0].value"
                value= "prometheus"
            },
            {
                name = "pushgateway.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "pushgateway.tolerations[0].effect"
                value= "NoSchedule"
            }
        ]
    }
    datadog = {
        name       = "datadog"
        namespace  = "datadog"
        repository = "https://helm.datadoghq.com"
        chart      = "datadog"
        custom_overrides = [
            {
                name = "datadog.apiKey"
            }
        ]
        overrides = [
            {
                name = "datadog.logs.enabled"
                value = true
            },
            {
                name = "datadog.logs.containerCollectAll"
                value = true
            },
            {
                name = "clusterAgent.nodeSelector.name"
                value = "datadog"
            },
            {
                name = "clusterAgent.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "clusterAgent.tolerations[0].value"
                value= "datadog"
            },
            {
                name = "clusterAgent.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "clusterAgent.tolerations[0].effect"
                value= "NoSchedule"
            },
            {
                name = "agents.nodeSelector.name"
                value = "datadog"
            },
            {
                name = "agents.tolerations[0].key"
                value= "namespace"
            },
            {
                name = "agents.tolerations[0].value"
                value= "datadog"
            },
            {
                name = "agents.tolerations[0].operator"
                value= "Equal"
            },
            {
                name = "agents.tolerations[0].effect"
                value= "NoSchedule"
            }
        ]
    }
}
