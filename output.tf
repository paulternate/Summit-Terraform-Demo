/////////////////////////////
///// Venafi Outputs

output "venafi_certificate-frontend" {
  value       = venafi_certificate.nginx-bankapp-frontend.certificate
  description = "The X509 certificate in PEM format."
}

output "venafi_chain-frontend" {
  value       = venafi_certificate.nginx-bankapp-frontend.chain
  description = "The trust chain of X509 certificate authority certificates in PEM format concatenated together."
}

output "venafi_private_key_pem-frontend" {
  sensitive   = true
  value       = venafi_certificate.nginx-bankapp-frontend.private_key_pem
  description = "The private key in PEM format."
}

output "venafi_certificate-processing" {
  value       = venafi_certificate.nginx-bankapp-processing.certificate
  description = "The X509 certificate in PEM format."
}

output "venafi_chain-processing" {
  value       = venafi_certificate.nginx-bankapp-processing.chain
  description = "The trust chain of X509 certificate authority certificates in PEM format concatenated together."
}

output "venafi_private_key_pem-processing" {
  sensitive   = true
  value       = venafi_certificate.nginx-bankapp-processing.private_key_pem
  description = "The private key in PEM format."
}

output "venafi_certificate-the-beam" {
  value       = venafi_certificate.nginx-bankapp-the-beam.certificate
  description = "The X509 certificate in PEM format."
}

output "venafi_chain-the-beam" {
  value       = venafi_certificate.nginx-bankapp-the-beam.chain
  description = "The trust chain of X509 certificate authority certificates in PEM format concatenated together."
}

output "venafi_private_key_pem-the-beam" {
  sensitive   = true
  value       = venafi_certificate.nginx-bankapp-the-beam.private_key_pem
  description = "The private key in PEM format."
}