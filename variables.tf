variable "tailscale_api_key" {
  description = "Tailscale API key for Terraform provider"
  type        = string
  sensitive   = true
}

variable "tailnet_name" {
  description = "Tailscale tailnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "Private subnet CIDR to advertise via subnet router"
  type        = string
  default     = "192.168.61.0/24"
}