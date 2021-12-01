variable "table_name" {
  description = "name of DDB table to apply autoscaler to"
  type        = string
}

variable "capacity" {
  type = map(any)
  default = {
    min_write = 5
    max_write = 100
    min_read  = 5
    max_read  = 100
  }
}

variable "write_target_value" {
  default = 70
}

variable "read_target_value" {
  default = 70
}
