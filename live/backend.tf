terraform {
  backend "s3" {
    # key    = "dev/tfsate"
    region       = "ap-northeast-1"
    use_lockfile = true
  }
}
