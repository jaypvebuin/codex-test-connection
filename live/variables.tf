variable "vendor" {
  type        = string
  description = "The name or identifier of the company. in this case 'Vb' for vebuin"
  default     = "Vb"
}

variable "environment" {
  type        = string
  description = "Must be one of: dev, stg or prod"
  default     = "demo"
}

variable "project_name" {
  type        = string
  description = "Indicates the name of the project."
  default     = "test"
}

variable "prefix" {
  type        = string
  description = "Used as a AWS service prefix or App specific names if available. If not specified it returns null."
  default     = "some-service"
  nullable    = true
}

#------------- vpc.tf ----------------

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default     = []
  type        = list(string)
}

variable "subnet_cidrs_private" {
  description = "Subnet CIDRs for private subnets (length must match configured availability_zones)"
  default     = []
  type        = list(string)
}
