# Background

Now we are running the instance as part of an autoscaling group. Even when instance is part of ASG,
we can not do any scaling as if we add more instances or more service containers we end up with different IP address or ports.
We can not access those containers uniformly. 

We need a way to load balance the requests between the containers and have a uniform way of reaching to them.

# Create infrastructure

- Add a route53 DNS entry to access the service through a URL instead of IP address or port. 

- Add a Application load balancer. 

- Update the security group to allow traffic only from load balancer.

