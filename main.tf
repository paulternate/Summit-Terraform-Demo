/////REQUIRED PROVIDERS
terraform {
    required_providers {
        venafi = {
            source = "Venafi/venafi"
            version = "~> 0.16.0"
        }
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 2.22.0" 
        }
    }
}

/////VARIABLE DEFINITIONS
variable "api_key" {
    description = "Venafi as a Service API Key"
    sensitive = true
}

variable "deploy_target" {
    description = "Target deployment environment."
}

/////PROVIDER
provider "venafi" {
    api_key = var.api_key
    zone = "BankApp\\${var.deploy_target} CA Template"
}

/////VENAFI MACHINE IDENTITY
resource "venafi_certificate" "nginx-bankapp-frontend" {
  common_name = "bankapp-frontend.venafidemo.com"
}

resource "venafi_certificate" "nginx-bankapp-processing" {
  common_name = "bankapp-processing.venafidemo.com"
}

resource "venafi_certificate" "nginx-bankapp-the-beam" {
  common_name = "bankapp-the-beam.venafidemo.com"

}

/////DOCKER
provider "docker" {
    host = "tcp://venafi-ecosystem-linux.vm.cld.sr:2376"
}

resource "docker_image" "nginx" {
    name = "paulternate/ssl-nginx"
    keep_locally = true
}

resource "docker_container" "nginx-bankapp-frontend" {
    name = "Bank-App-frontend"
    image = docker_image.nginx.image_id
    ports {
        internal = "443"
        external = "8443"
        ip = "0.0.0.0"
    }

    # Inject the key and certificate into the NGINX docker container.
    upload {
        content = venafi_certificate.nginx-bankapp-frontend.certificate
        file = "/etc/nginx/ssl/certificate.pem"
    }

    upload {
        content = venafi_certificate.nginx-bankapp-frontend.private_key_pem
        file = "/etc/nginx/ssl/privatekey.pem"
    }

    upload {
        source = "assets/index-frontend.html"
        file = "/var/www/index.html"
    }

    upload {
        source = "assets/styles.css"
        file = "/var/www/styles.css"
    }

    upload {
        source = "assets/images/background-frontend.png"
        file = "/var/www/background.png"
    }
}

resource "docker_container" "nginx-bankapp-processing" {
    name = "Bank-App-processing"
    image = docker_image.nginx.image_id
    ports {
        internal = "443"
        external = "8444"
        ip = "0.0.0.0"
    }

    upload {
        content = venafi_certificate.nginx-bankapp-processing.certificate
        file = "/etc/nginx/ssl/certificate.pem"
    }

    upload {
        content = venafi_certificate.nginx-bankapp-processing.private_key_pem
        file = "/etc/nginx/ssl/privatekey.pem"
    }

    upload {
        source = "assets/index-processing.html"
        file = "/var/www/index.html"
    }

    upload {
        source = "assets/styles.css"
        file = "/var/www/styles.css"
    }

    upload {
        source = "assets/images/background-processing.png"
        file = "/var/www/background.png"
    }
}

resource "docker_container" "nginx-bankapp-the-beam" {
    name = "Bank-App-the-beam"
    image = docker_image.nginx.image_id
    ports {
        internal = "443"
        external = "8445"
        ip = "0.0.0.0"
    }

    upload {
        content = venafi_certificate.nginx-bankapp-the-beam.certificate
        file = "/etc/nginx/ssl/certificate.pem"
    }

    upload {
        content = venafi_certificate.nginx-bankapp-the-beam.private_key_pem
        file = "/etc/nginx/ssl/privatekey.pem"
    }

    upload {
        source = "assets/index-the-beam.html"
        file = "/var/www/index.html"
    }

    upload {
        source = "assets/styles.css"
        file = "/var/www/styles.css"
    }

    upload {
        source = "assets/images/background-the-beam.png"
        file = "/var/www/background.png"
    }
}
