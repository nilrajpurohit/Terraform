variable "namespace_name" {
    type = string
}
variable "replicas" {
    type = number
}
variable "app_image" {
  description = "Container image"
  type = string
}