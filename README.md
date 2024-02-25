# Create a Debian EC2 Instance and a security group

This IaC creates an EC2 instance based on the latest debian 12 AMI available from amazon.

Additionally, it creates a security group that allows ingress from a custom IP.

## Prerequisites

Gather the following info:
 * ip address / address range that should be allowed to connect to the EC2 instance
 * AWS key pair name
 * vpc id for desired AWS region

Ensure your environment has the proper ssh key for your AWS key pair.

Ensure your terminal has active AWS session credentials using the following env variables:
 * AWS_ACCESS_KEY_ID
 * AWS_SECRET_ACCESS_KEY
 * AWS_SESSION_TOKEN

## Procedure

```terraform init```

```terraform plan```

Enter user input for ingress ip address, AWS key pair name, and vpc id

```terraform apply```

Enter user input again

After the EC2 instance and security group are created, terraform should output the public dns of the EC2 instance.

## Validation

You should now be able to ssh into the new debian EC2 instance. The default username for debian is admin.

```ssh -i /path/to/<pem or ppk file> admin@<public dns output of terraform apply>```
