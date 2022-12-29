terraform {
  cloud {
    organization = "inno-island"
    workspaces {
      name = "tf-private-api"
    }
  }
}