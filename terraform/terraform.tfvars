cluster_name_prefix = "eks"
cidr                = "192.168.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b","us-east-1c"]
node_groups = {
    default = {
        node_group_name          = "default"
        node_group_instance_type = "t2.medium"
        node_group_ami_type      = "BOTTLEROCKET_x86_64"
        desired_worker_nodes     = 1
        max_worker_nodes         = 1
        min_worker_nodes         = 1
        taints = []
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
                name = "server.extraArgs"
                value = "{--auth-mode=server}"
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
            }
        ]
    }
}
