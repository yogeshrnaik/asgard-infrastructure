### CLUSTER Setup testing

The created cluster is tested by deploying nginx service on the cluster. 

- Update `terraform.tfvars` with values for the cluster and ALB to test
- Run `terraform init`
- Run `terraform plan -out=tfplan.out`
- Run `terraform apply tfplan.out`
- Use the `test_endpoint` in the output to verify that a nginx service is deployed on the cluster
- Run `terraform plan -destroy -out=tfplan.out`
- Run `terraform apply tfplan.out`