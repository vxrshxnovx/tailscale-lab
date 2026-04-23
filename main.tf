terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.28"
    }
  }
}

provider "tailscale" {
  api_key = var.tailscale_api_key
  tailnet = var.tailnet_name
}

resource "tailscale_acl" "main" {
  acl = jsonencode({
    tagOwners = {
      "tag:subnet-router" = []
      "tag:laptop"        = []
      "tag:phone"         = []
    }

    acls = [
      {
        action = "accept"
        src    = ["tag:laptop"]
        dst    = ["tag:subnet-router:*", "tag:phone:*", "192.168.61.0/24:*"]
      },
      {
        action = "accept"
        src    = ["tag:phone"]
        dst    = ["tag:laptop:*"]
      }
    ]

    autoApprovers = {
      routes = {
        "192.168.61.0/24" = ["tag:subnet-router"]
      }
    }
  })
}

resource "tailscale_tailnet_key" "subnet_router_key" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 3600
  description   = "Subnet router auth key"
  tags          = ["tag:subnet-router"]

  depends_on = [tailscale_acl.main]
}

resource "tailscale_tailnet_key" "phone_auth_key" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 3600
  description   = "Phone auth key"
  tags          = ["tag:phone"]

  depends_on = [tailscale_acl.main]
}