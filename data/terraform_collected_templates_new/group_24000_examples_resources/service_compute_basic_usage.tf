data "fastly_package_hash" "example" {
  filename = "./path/to/package.tar.gz"
}

resource "fastly_service_compute" "example" {
  name = "demofastly"

  domain {
    name    = "demo.notexample.com"
    comment = "demo"
  }

  package {
    filename         = "package.tar.gz"
    source_code_hash = data.fastly_package_hash.example.hash
  }

  force_destroy = true
}
