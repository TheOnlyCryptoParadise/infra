variable "candle_layer_location" {
  description = "location of file with zipped dependencies for candle_getter"
  type = string
  default = "../candle_getter/build/candle_getter_layer.zip"
}

variable "candle_getter_package_location" {
  description = "location of file with zipped code for candle_getter"
  type = string
  default = "../candle_getter/build/candle_getter_package.zip"
}
