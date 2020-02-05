# code_challenge
# Senior Systems Engineer Code Challenge

 1. Publish a git repository that our engineering team can clone or submit an archive file (tarball, zip, etc) that contains the code
 2. I should be able to easily deploy a Docker container containing [a simple _Hello World!_ app](https://hub.docker.com/r/training/webapp/) that we can request using the command line utility `curl` and to get the expected response.
 3. I should also be able to publish that app to AWS or Azure very simply
 4. The app should be fronted by a Load Balancer
 5. The app should be integrated into the cloud provider's monitoring solution
 6. We highly value using an _infrastructure as code_ approach to do this.  We use Terraform, but are pretty well-versed in most tools to achieve this.
 7. All the resources provisioned in the cloud provider should be well-configured and locked down.  This means that security groups are in place and there isn't unecessary public access to resources.

# pre-req
1. have aws cli access to us-west-2 (or edit region to include appropriate ami's)
2. edit variables.tf
3. terraform init / terraform apply (kept all tf's in same directory for easy one and done apply )

Caveats (WIP - I'll add these on request):

1. availability_zones, only in west-2a - could be expanded.
2. given bigger project would include granular modules, and expand environments.
3. staying in free-tier zone on personal aws account. (t2.micro - network performance bottleneck)
4. us-west-2 is default, also edit variables.tf for keys/access
5. route53 zone to be implemented + terraform for the automation work
6. interpolation warning -

Warning: Interpolation-only expressions are deprecated
this, I removed the expressions, but then :thumbsdown:

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

didn't quite resolve this one yet.
7. and aws_cloudwatch_metric_alarm, able to get some alarms set, but not so attached to ELB.
8. call ELB on port 32769 for the "hello world!"
