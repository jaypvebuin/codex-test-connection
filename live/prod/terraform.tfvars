vendor = "vb"
project_name = "project"
Environment = "prod"

#------------- vpc.tf ----------------
ipv4_cidr_block      = "11.2.0.0/16"
subnet_cidrs_public = ["11.2.1.0/24", "11.2.2.0/24", "11.2.3.0/24"]
subnet_cidrs_private = ["11.2.4.0/24", "11.2.5.0/24", "11.2.6.0/24"]