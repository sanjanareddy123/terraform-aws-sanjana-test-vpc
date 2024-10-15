output "vpc" {
  value = module.my-test-vpc.vpc_id
}
output "public_subnet_id" {
  value = module.my-test-vpc.public_subnet_id
}
output "private_subnet_id" {
  value = module.my-test-vpc.private_subnet_id
}