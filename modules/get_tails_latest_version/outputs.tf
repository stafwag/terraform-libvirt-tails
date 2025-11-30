output "tails_json" {

  value = data.http.tails_json

}

output "jsonData" {

  value = local.jsonData

}

output "tails_version" {

  value = local.jsonData.installations[0].version

}
