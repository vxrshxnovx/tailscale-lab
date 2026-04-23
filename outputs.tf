output "subnet_router_auth_key" {
  value       = tailscale_tailnet_key.subnet_router_key.key
  sensitive   = true
  description = "Auth key for the subnet router VM to join the tailnet"
}

output "phone_auth_key" {
  value       = tailscale_tailnet_key.phone_auth_key.key
  sensitive   = true
  description = "Auth key for iOS device"
}