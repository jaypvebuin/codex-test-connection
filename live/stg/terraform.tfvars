vendor = "vb"
project_name = "project"
Environment = "stg"

#------------- vpc.tf ----------------
ipv4_cidr_block      = "11.1.0.0/16"
subnet_cidrs_public = ["11.1.1.0/24", "11.1.2.0/24", "11.1.3.0/24"]
subnet_cidrs_private = ["11.1.4.0/24", "11.1.5.0/24", "11.1.6.0/24"]