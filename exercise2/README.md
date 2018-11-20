# Background

We could run Nginx on our cluster. This is simple but has following problems

- If we lose the instance we will lose the service.

We need to run the instance as part of auto-scaling group.

# Create infrastructure

- Add autoscaling group

- Create launch configuration to launch instances 

- Use the same Security group but attach it to Launch configuration.  

- Attach the created IAM role to launch configuration.

