vendor = "vb"
project_name = "project"
Environment = "dev"

#------------- vpc.tf ----------------
ipv4_cidr_block      = "11.0.0.0/16"
subnet_cidrs_public = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
subnet_cidrs_private = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24"]