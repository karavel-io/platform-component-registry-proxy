# Configuration

```hcl
component "registry-proxy" {
  namespace = "registry-proxy"

  remoteurl = "https://registry-1.docker.io" # required, Registry URL to proxy

  # if using s3 for storage, this section is required and must point to an S3 bucket
  s3 = {
    region = ""        # required, bucket region
    bucket = ""        # required, bucket name
    endpoint = ""      # required, S3 endpoint
    encrypt = true     # required, enable to use server-side encryption
    secure = true      # required, enable to use HTTPS instead of HTTP
    skipverify = false # required, enable to skip certificate validation
    v4auth = true      # required, Use AWS v4 signature version (disable if experiencing compatibility issues)
    prefix = ""        # optional, specify to use a different prefix than root directory
    eksRole = ""       # optional, EKS role
    iamRole = ""       # optional, IAM role
  }

  # optional, secrets with user credentials to authenticate to the registry
  secret = {
    # override this section only if you are not using the default store from the external-secrets component
    store = {
      name = "default"
      kind = "ClusterSecretStore"
    }
    key = "" # required, should be the store-specific key to the secret, e.g. the Vault or AWS Secrets Manager key
  }
}
```

## Secrets

Secrets referenced by the configuration must be provisioned in the backend service of your choice before installing the registry proxy.

Unless you changed the configuration of the External Secret component or manually provisioned a custom `SecretStore` resource, you don't need to override the `store` section of each secret reference.
