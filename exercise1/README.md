# Background

Now we have a docker image for the service Odin. Now we need infrastructure to run the container on AWS cloud.

# Create infrastructure

- Create an ECS cluster

- Create an EC2 instance in public subnet. The instance needs to join the ECS cluster. 

- Create Security group to allow traffic on the instance. 

- Create IAM role for the instance to allow ECS agent to interact with ECR and other AWS services.

- Test the cluster with a test service (Nginx deployed to the cluster)