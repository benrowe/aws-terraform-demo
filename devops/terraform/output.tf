output "api_host" {
  value = ""
}

output "web_uri" {
  value = module.ecr_web.url
}

output "app_uri" {
  value = module.ecr_app.url
}

output "worker_uri" {
  value = module.ecr_worker.url
}
