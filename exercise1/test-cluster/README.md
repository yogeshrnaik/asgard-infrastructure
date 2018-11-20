### CLUSTER Setup testing

The created cluster is tested by deploying nginx service on the cluster. 

- Update `terraform-<env>.tfvars` with values for the cluster and ALB to test
- Run `terraform init`
- Run `terraform plan -out=tfplan.out -var-file=terraform-<env>.tfvars`
- Run `terraform apply tfplan.out`
- Use the `test_endpoint` in the output to verify that a nginx service is deployed on the cluster
- Run `terraform plan -destroy -out=tfplan.out -var-file=terraform-<env>.tfvars`
- Run `terraform apply tfplan.out`