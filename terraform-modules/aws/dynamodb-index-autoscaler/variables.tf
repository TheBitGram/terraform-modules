variable "index_name" {
  description = "name of DDB Index to apply autoscaler to"
  type        = string
}

variable "table_name" {
  description = "name of DDB table the index belongs to"
  type        = string
}

variable "capacity" {
  type = map(any)
  default = {
    min_write = 1
    max_write = 100
    min_read  = 1
    max_read  = 100
  }
}

variable "write_target_value" {
  default = 70
}

variable "read_target_value" {
  default = 70
}
