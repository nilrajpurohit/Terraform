output "namespace" {
    value = kubernetes_namespace_v1.beginner.metadata[0].name
}
output "deployment_name" {
  value = kubernetes_deployment_v1.nginx.metadata[0].name
}
output "service_name" {
  value = kubernetes_service_v1.nginx.metadata[0].name
}
output "existing_namespace_from_data_source" {
  value = data.kubernetes_namespace_v1.existing.metadata[0].name
}
output "configmaps_created_with_count" {
  value = [
    for cm in kubernetes_config_map_v1.count :
    cm.metadata[0].name
  ]
}
output "configmaps_created_with_foreach" {
  value = [
    for cm in kubernetes_config_map_v1.foreach :
    cm.metadata[0].name
  ]
}