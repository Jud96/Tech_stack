## input variables

- input variables are parameters for a Terraform module
- input variables are defined in a module block
- input variables are assigned values in a module block


### types of input variables

| type | description | access to variable |
|------|-------------|
| string | a sequence of characters | ${var.variable_name} |
| number | a numeric value | ${var.variable_name} |
| bool | a boolean value | ${var.variable_name} |
| list | a list of values | ${var.variable_name[index]} |
| map | a set of key-value pairs | ${var.variable_name["key"]} |
| object | a complex type with attributes | ${var.variable_name.attribute} |
| set | a set of distinct values | ${var.variable_name} |

