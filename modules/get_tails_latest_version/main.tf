#
# There are two ways to get the latest tails version
#
# 1. Query the tail git repository for the latest tag
# 2. Check the release RSS feed
#
# Using the RSS feed as there may be a delay between the release on
# the tails repository and the official release
#

data "http" "tails_json" {

  url = "https://tails.net/install/v2/Tails/amd64/stable/latest.json"

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status ${self.status_code} code invalid"
    }
  }

}

locals {

  jsonData  = jsondecode(data.http.tails_json.response_body)

}
