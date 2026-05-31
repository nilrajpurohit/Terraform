# Terraform Complete Roadmap
### From Beginner to Expert

---

# Table of Contents

## 🟢 Beginner Level — Terraform Fundamentals

1. [Prerequisites](#1-prerequisites)
2. [What is Terraform?](#2-what-is-terraform)
3. [Terraform Architecture](#3-terraform-architecture)
4. [Installation & Setup](#4-installation--setup)
5. [HCL Syntax](#5-hcl-syntax)
6. [Core CLI Commands](#6-core-cli-commands)
7. [Providers](#7-providers)
8. [Resources & Data Sources](#8-resources--data-sources)
9. [Variables & Outputs](#9-variables--outputs)
10. [State Basics](#10-state-basics)
11. [Meta-Arguments](#11-meta-arguments)
12. [Beginner Hands-On Checklist](#12-beginner-checklist)

---

## 🔵 Intermediate Level — Building Real Infrastructure

13. [Modules](#1-modules)
14. [Remote State Backends](#2-remote-state-backends)
15. [State Locking](#3-state-locking)
16. [Workspaces](#4-workspaces)
17. [Built-in Functions](#5-built-in-functions)
18. [Loops & Dynamic Blocks](#6-loops--dynamic-blocks)
19. [Secrets Management](#7-secrets-management)
20. [Multi-Environment Patterns](#8-multi-environment-patterns)
21. [terraform import](#9-terraform-import)
22. [Provisioners](#10-provisioners)
23. [Data Sources Deep Dive](#11-data-sources-deep-dive)
24. [Project Structure](#12-project-structure)
25. [Intermediate Hands-On Checklist](#13-intermediate-checklist)

---

## 🟠 Advanced Level — Production & Automation

26. [CI/CD Integration](#1-cicd-integration)
27. [GitOps with Atlantis](#2-gitops-with-atlantis)
28. [Custom Providers](#3-custom-providers)
29. [CDKTF](#4-cdktf)
30. [Testing with Terratest](#5-testing-with-terratest)
31. [Native TF Tests (1.6+)](#6-native-tf-tests-16)
32. [Policy as Code](#7-policy-as-code)
33. [State Manipulation](#8-state-manipulation)
34. [Multi-Account Scale](#9-multi-account-scale)
35. [Drift Detection](#10-drift-detection)
36. [Refactoring Blocks](#11-refactoring-blocks)
37. [Advanced Deployments](#12-advanced-deployments)
38. [Advanced Hands-On Checklist](#13-advanced-checklist)

---

## 🔴 Expert Level — Platform Engineering & Scale

39. [Platform Engineering](#1-platform-engineering)
40. [Terragrunt](#2-terragrunt)
41. [Ecosystem & Alternatives](#3-ecosystem--alternatives)
42. [OpenTofu](#4-opentofu)
43. [Private Module Registry](#5-private-module-registry)
44. [Security at Depth](#6-security-at-depth)
45. [Static Analysis](#7-static-analysis)
46. [Terraform Cloud / Enterprise](#8-terraform-cloud--enterprise)
47. [Module Composition Patterns](#9-module-composition-patterns)
48. [Contributing to OSS](#10-contributing-to-oss)
49. [TF Associate Certification](#11-tf-associate-certification)
50. [FinOps & Cost Control](#12-finops--cost-control)
51. [Expert Hands-On Checklist](#13-expert-checklist)

---

## 🧪 Real-World Projects

52. [Beginner Projects](#beginner-projects)
53. [Intermediate Projects](#intermediate-projects)
54. [Advanced Projects](#advanced-projects)
55. [Expert-Level Projects](#expert-level-projects)

---

## 📚 Learning Resources

56. [Official Documentation](#official-documentation)
57. [Books](#books)
58. [Hands-On Labs](#hands-on-labs)
59. [Video Courses](#video-courses)

---

## 🏆 Certification Path

60. [HashiCorp Terraform Associate (003)](#certification-path)

---

## 🗺️ Learning Timeline Summary

61. [Complete Learning Path Summary](#-complete-learning-path-summary)

---

## 🟢 Beginner Level

> **Goal:** Understand what Terraform is, why it exists, and how to provision infrastructure at a basic level.
> **Estimated Time:** 2–4 weeks

---

### 1. Prerequisites

Before touching Terraform, be comfortable with:

- **Linux fundamentals** — file system, processes, basic shell usage
- **Cloud basics** — at least one of AWS, Azure, or GCP (accounts, IAM, basic services)
- **Basic networking** — IP addressing, DNS, ports, HTTP/HTTPS
- **YAML / JSON syntax** — reading and writing config files
- **Command line proficiency** — environment variables, shell scripting basics
- **Git** — version control, branching, pull requests

---

### 2. What is Terraform?

- **Infrastructure as Code (IaC)** tool created by HashiCorp
- Allows you to define, provision, and manage cloud infrastructure using declarative configuration files
- Open-source (MPL 2.0 for OpenTofu; BSL 1.1 for HashiCorp Terraform since 2023)
- Governed and widely supported by the **CNCF** ecosystem

#### Why Terraform?

| Feature | Benefit |
|---------|---------|
| **Declarative syntax** | Define *what* you want, not *how* to get there |
| **Provider ecosystem** | 3,000+ providers (AWS, Azure, GCP, Kubernetes, etc.) |
| **State management** | Tracks real-world resource state |
| **Plan before apply** | Preview changes before they happen |
| **Idempotent** | Run many times, same result |

---

### 3. Terraform Architecture

```
Terraform Core
┌──────────────────────────────────────────────┐
│  Configuration Files (.tf)                   │
│  State File (terraform.tfstate)              │
│  Terraform CLI (plan / apply / destroy)      │
└──────────────────┬───────────────────────────┘
                   │
          Provider Plugin Layer
     ┌─────────────┼─────────────┐
     ▼             ▼             ▼
  AWS API      Azure API     GCP API
```

#### Key Components

| Component | Description |
|-----------|-------------|
| **Configuration** | `.tf` files written in HCL defining desired infrastructure |
| **Provider** | Plugin that translates Terraform calls to cloud API calls |
| **Resource** | A single infrastructure object (e.g., EC2 instance, VPC) |
| **State** | JSON file tracking what Terraform has created |
| **Plan** | Diff between desired config and current state |
| **Workspace** | Isolated state environments within one config |

---

### 4. Installation & Setup

Choose an installation method:

- **Direct binary** — download from [releases.hashicorp.com](https://releases.hashicorp.com/terraform/)
- **tfenv** — version manager for Terraform (recommended)
- **Homebrew** (macOS) — `brew install terraform`
- **Chocolatey** (Windows) — `choco install terraform`

```bash
# Install tfenv (recommended)
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc

# Install a specific Terraform version
tfenv install 1.9.0
tfenv use 1.9.0

# Verify installation
terraform version
```

#### Recommended Project Structure

```
my-project/
├── main.tf           # Primary resources
├── variables.tf      # Input variable declarations
├── outputs.tf        # Output value declarations
├── providers.tf      # Provider configuration
├── versions.tf       # Required versions block
├── terraform.tfvars  # Variable values (do NOT commit secrets)
└── .gitignore        # Exclude .terraform/, *.tfstate
```

---

### 5. HCL Syntax

HCL (HashiCorp Configuration Language) is the language used to write Terraform configuration.

```hcl
# Block syntax
<BLOCK_TYPE> "<BLOCK_LABEL>" "<BLOCK_LABEL>" {
  argument = value
}

# Example: resource block
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  tags = {
    Name        = "web-server"
    Environment = "production"
  }
}

# Comments
# Single-line comment
/* Multi-line
   comment */
```

#### Value Types

| Type | Example |
|------|---------|
| `string` | `"hello"` |
| `number` | `42`, `3.14` |
| `bool` | `true`, `false` |
| `list` | `["a", "b", "c"]` |
| `map` | `{ key = "value" }` |
| `object` | `{ name = string, age = number }` |

---

### 6. Core CLI Commands

```bash
# Initialize working directory (downloads providers)
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply

# Apply without interactive prompt
terraform apply -auto-approve

# Destroy all managed resources
terraform destroy

# Format code to canonical style
terraform fmt

# Validate configuration syntax
terraform validate

# Show current state
terraform show

# List resources in state
terraform state list

# Output current workspace
terraform workspace show
```

---

### 7. Providers

Providers are plugins that allow Terraform to interact with APIs.

```hcl
# versions.tf — pin provider versions
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# providers.tf — configure the provider
provider "aws" {
  region  = "us-east-1"
  profile = "my-aws-profile"   # from ~/.aws/credentials
}
```

#### Common Providers

| Provider | Source |
|----------|--------|
| AWS | `hashicorp/aws` |
| Azure | `hashicorp/azurerm` |
| GCP | `hashicorp/google` |
| Kubernetes | `hashicorp/kubernetes` |
| Helm | `hashicorp/helm` |
| Random | `hashicorp/random` |

---

### 8. Resources & Data Sources

#### Resource Block
Defines infrastructure to be created and managed by Terraform.

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-2024"

  tags = {
    Environment = "dev"
  }
}

# Reference another resource
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id   # resource reference

  versioning_configuration {
    status = "Enabled"
  }
}
```

#### Data Source Block
Reads existing infrastructure (not managed by this config).

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]   # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

# Use the data source
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}
```

---

### 9. Variables & Outputs

#### Input Variables

```hcl
# variables.tf
variable "region" {
  type        = string
  description = "AWS region to deploy to"
  default     = "us-east-1"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "allowed_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "tags" {
  type = map(string)
  default = {
    Team = "platform"
  }
}
```

#### Providing Variable Values

```bash
# Using a .tfvars file (terraform.tfvars is auto-loaded)
region         = "eu-west-1"
instance_count = 3

# On the command line
terraform apply -var="region=eu-west-1"

# Via environment variable
export TF_VAR_region="eu-west-1"
```

#### Output Values

```hcl
# outputs.tf
output "instance_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.bucket
  sensitive   = false
}
```

---

### 10. State Basics

Terraform state (`terraform.tfstate`) is the source of truth for what Terraform manages.

```bash
# View current state
terraform show

# List all resources in state
terraform state list

# Inspect a specific resource
terraform state show aws_instance.web
```

#### State File (simplified)

```json
{
  "version": 4,
  "terraform_version": "1.9.0",
  "resources": [
    {
      "type": "aws_instance",
      "name": "web",
      "instances": [
        {
          "attributes": {
            "id": "i-0abc123def456",
            "public_ip": "54.123.45.67"
          }
        }
      ]
    }
  ]
}
```

> **Warning:** Never manually edit `terraform.tfstate`. Always use Terraform CLI commands to manipulate state.

---

### 11. Meta-Arguments

Meta-arguments change the behavior of any resource block.

#### `depends_on`
Explicit dependency when Terraform cannot infer it automatically.

```hcl
resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  depends_on = [aws_iam_role_policy.app_policy]
}
```

#### `count`
Create multiple copies of a resource.

```hcl
resource "aws_instance" "web" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "web-${count.index}"
  }
}
```

#### `for_each`
Create resources from a map or set.

```hcl
resource "aws_s3_bucket" "env_buckets" {
  for_each = toset(["dev", "staging", "prod"])
  bucket   = "my-app-${each.key}"
}
```

#### `lifecycle`
Control resource replacement and update behavior.

```hcl
resource "aws_instance" "web" {
  # ...
  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [tags]
  }
}
```

---

### 12. Beginner Checklist

- [ ] Install Terraform and configure a cloud provider
- [ ] Write your first `.tf` file and run `terraform init`, `plan`, `apply`
- [ ] Create a resource (e.g., S3 bucket or resource group) using Terraform
- [ ] Use input variables and a `terraform.tfvars` file
- [ ] Define an output value and view it after apply
- [ ] Use a data source to reference existing infrastructure
- [ ] Use `count` to create multiple resources
- [ ] Use `for_each` to iterate over a map
- [ ] Use a `lifecycle` block with `prevent_destroy`
- [ ] Destroy all resources with `terraform destroy`

---

## 🔵 Intermediate Level

> **Goal:** Build reusable, production-friendly infrastructure with modules, remote state, and proper project structure.
> **Estimated Time:** 4–8 weeks

---

### 1. Modules

Modules are reusable containers for Terraform configuration. Every Terraform configuration is technically a module.

```
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── README.md
```

#### Calling a Module

```hcl
module "vpc" {
  source  = "./modules/vpc"    # local module
  # source = "terraform-aws-modules/vpc/aws"  # registry module
  version = "5.0.0"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]
  name     = "my-vpc"
}

# Reference module output
output "vpc_id" {
  value = module.vpc.vpc_id
}
```

#### Module Sources

| Source Type | Example |
|-------------|---------|
| Local path | `./modules/vpc` |
| Terraform Registry | `terraform-aws-modules/vpc/aws` |
| GitHub | `github.com/org/repo//modules/vpc` |
| S3 (private) | `s3::https://bucket.s3.amazonaws.com/modules/vpc.zip` |

---

### 2. Remote State Backends

Store state remotely for team collaboration and durability.

#### S3 Backend (AWS)

```hcl
# versions.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "prod/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

#### Terraform Cloud Backend

```hcl
terraform {
  cloud {
    organization = "my-org"
    workspaces {
      name = "prod-vpc"
    }
  }
}
```

#### Azure Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

---

### 3. State Locking

Prevents concurrent state modifications that could corrupt state.

```
Developer A                    Developer B
terraform apply                terraform apply
     │                               │
     ▼                               ▼
Acquire DynamoDB Lock ──────► Lock already held
     │                         Wait / Error
     ▼
Apply changes
     │
     ▼
Release lock
```

- **AWS:** DynamoDB table (`LockID` as primary key)
- **Azure:** Blob storage lease
- **GCS:** Object lock
- **Terraform Cloud:** Built-in locking

---

### 4. Workspaces

Workspaces allow multiple state files from the same configuration.

```bash
# List workspaces
terraform workspace list

# Create a new workspace
terraform workspace new staging

# Switch workspace
terraform workspace select prod

# Current workspace
terraform workspace show
```

#### Using Workspace in Configuration

```hcl
locals {
  env = terraform.workspace   # "default", "staging", "prod"
}

resource "aws_instance" "web" {
  instance_type = local.env == "prod" ? "t3.medium" : "t3.micro"
  # ...
}
```

> **Note:** Workspaces are convenient for quick isolation but not recommended for managing entirely separate environments. Use separate directories or root modules for stronger isolation.

---

### 5. Built-in Functions

Terraform includes 100+ built-in functions for transforming values.

#### String Functions

```hcl
upper("hello")         # "HELLO"
lower("WORLD")         # "world"
replace("foo bar", " ", "-")   # "foo-bar"
trimspace("  hello  ")         # "hello"
format("Hello, %s!", "World")  # "Hello, World!"
```

#### Collection Functions

```hcl
length(["a", "b", "c"])        # 3
toset(["a", "b", "a"])         # toset(["a", "b"])
merge({a=1}, {b=2})            # {a=1, b=2}
flatten([[1,2],[3]])           # [1, 2, 3]
keys({a=1, b=2})               # ["a", "b"]
lookup({a=1}, "a", 0)          # 1
```

#### Encoding & File Functions

```hcl
base64encode("hello")          # "aGVsbG8="
jsonencode({key = "value"})    # "{\"key\":\"value\"}"
file("./scripts/init.sh")      # reads file contents
templatefile("./tmpl.tpl", {name = "world"})
```

---

### 6. Loops & Dynamic Blocks

#### `for` Expressions

```hcl
# Transform a list
variable "names" {
  default = ["alice", "bob", "charlie"]
}

output "upper_names" {
  value = [for n in var.names : upper(n)]
}

# Filter with condition
output "long_names" {
  value = [for n in var.names : n if length(n) > 4]
}

# Create a map from a list
output "name_lengths" {
  value = { for n in var.names : n => length(n) }
}
```

#### Dynamic Blocks

```hcl
variable "ingress_rules" {
  default = [
    { port = 80,  cidr = "0.0.0.0/0" },
    { port = 443, cidr = "0.0.0.0/0" },
  ]
}

resource "aws_security_group" "web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr]
    }
  }
}
```

---

### 7. Secrets Management

Never store secrets in plaintext `.tf` files or commit them to version control.

#### Approach 1 — Environment Variables

```bash
export TF_VAR_db_password="supersecret"
```

#### Approach 2 — AWS SSM Parameter Store

```hcl
data "aws_ssm_parameter" "db_password" {
  name            = "/myapp/prod/db_password"
  with_decryption = true
}

resource "aws_db_instance" "main" {
  password = data.aws_ssm_parameter.db_password.value
  # ...
}
```

#### Approach 3 — HashiCorp Vault

```hcl
provider "vault" {
  address = "https://vault.example.com"
}

data "vault_generic_secret" "db" {
  path = "secret/myapp/database"
}

output "db_user" {
  value     = data.vault_generic_secret.db.data["username"]
  sensitive = true
}
```

#### Mark Outputs as Sensitive

```hcl
output "db_password" {
  value     = var.db_password
  sensitive = true   # Redacted in CLI output
}
```

---

### 8. Multi-Environment Patterns

#### Pattern 1 — Folder per Environment (Recommended)

```
infra/
├── modules/
│   ├── vpc/
│   └── ec2/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       └── terraform.tfvars
```

#### Pattern 2 — tfvars per Environment

```bash
# Apply for dev
terraform apply -var-file="envs/dev.tfvars"

# Apply for prod
terraform apply -var-file="envs/prod.tfvars"
```

---

### 9. terraform import

Import existing cloud infrastructure into Terraform state.

```bash
# Legacy import (Terraform < 1.5)
terraform import aws_instance.web i-0abc123def456

# Block-based import (Terraform >= 1.5 — recommended)
```

```hcl
# main.tf
import {
  to = aws_instance.web
  id = "i-0abc123def456"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
}
```

```bash
# Generate config from existing resource (Terraform 1.5+)
terraform plan -generate-config-out=generated.tf
```

---

### 10. Provisioners

Provisioners run scripts on resources after creation. Use sparingly — prefer cloud-init, user_data, or configuration management tools.

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  # Run a local command after creation
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ip_list.txt"
  }

  # Run a command on the remote machine
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
```

> **Best Practice:** Provisioners are a last resort. They break idempotency and make plans less predictable. Prefer `user_data`, AMIs, or Ansible for configuration management.

---

### 11. Data Sources Deep Dive

```hcl
# Look up current AWS account ID
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Look up available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Look up remote state from another Terraform config
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "prod/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# Use the output from another stack
resource "aws_instance" "web" {
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_id
  # ...
}
```

---

### 12. Project Structure

#### Small Project

```
project/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── terraform.tfvars
```

#### Large Project (Module-based)

```
platform/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   └── database/
├── environments/
│   ├── dev/
│   │   ├── main.tf          # calls modules
│   │   ├── providers.tf
│   │   ├── versions.tf
│   │   └── terraform.tfvars
│   └── prod/
│       └── ...
└── README.md
```

---

### 13. Intermediate Checklist

- [ ] Write a reusable module and call it from a root module
- [ ] Configure a remote backend (S3 + DynamoDB or Terraform Cloud)
- [ ] Enable state locking and verify it works
- [ ] Use `for_each` to manage multiple similar resources
- [ ] Use dynamic blocks to generate repeated nested blocks
- [ ] Manage secrets using SSM or Vault (not hardcoded)
- [ ] Structure a project with dev/staging/prod environments
- [ ] Import an existing resource using `import` blocks (TF 1.5+)
- [ ] Use `terraform_remote_state` to share outputs across stacks
- [ ] Use built-in functions: `merge`, `lookup`, `flatten`, `jsonencode`

---

## 🟠 Advanced Level

> **Goal:** Automate Terraform at scale with CI/CD, testing, policy enforcement, and custom tooling.
> **Estimated Time:** 6–10 weeks

---

### 1. CI/CD Integration

#### GitHub Actions — Plan on PR, Apply on Merge

```yaml
# .github/workflows/terraform.yml
name: Terraform

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    permissions:
      id-token: write       # OIDC auth to AWS
      contents: read
      pull-requests: write

    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/TerraformRole
          aws-region: us-east-1

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: "1.9.0"

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan -out=tfplan
        if: github.event_name == 'pull_request'

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
```

---

### 2. GitOps with Atlantis

Atlantis runs Terraform `plan` and `apply` automatically based on pull requests.

```yaml
# atlantis.yaml
version: 3
projects:
  - name: prod-vpc
    dir: environments/prod
    workspace: default
    autoplan:
      when_modified:
        - "*.tf"
        - "../modules/**/*.tf"
    apply_requirements:
      - approved
      - mergeable
```

**Workflow:**
1. Engineer opens a PR
2. Atlantis runs `terraform plan` and comments the diff on the PR
3. Team reviews and approves
4. Engineer comments `atlantis apply`
5. Atlantis applies and merges the PR

---

### 3. Custom Providers

Write providers in Go using the Terraform Plugin Framework.

```
my-provider/
├── main.go
├── internal/
│   └── provider/
│       ├── provider.go
│       └── resource_thing.go
├── go.mod
└── go.sum
```

```go
// internal/provider/provider.go
package provider

import (
    "github.com/hashicorp/terraform-plugin-framework/provider"
)

type MyProvider struct{}

func (p *MyProvider) Metadata(_ context.Context, _ provider.MetadataRequest, resp *provider.MetadataResponse) {
    resp.TypeName = "myprovider"
    resp.Version  = "0.1.0"
}
```

```bash
# Test locally
go build -o terraform-provider-myprovider
mkdir -p ~/.terraform.d/plugins/registry.example.com/myorg/myprovider/0.1.0/linux_amd64
mv terraform-provider-myprovider ~/.terraform.d/plugins/...
```

---

### 4. CDKTF

CDK for Terraform allows writing Terraform in programming languages.

```bash
# Install CDKTF CLI
npm install -g cdktf-cli

# Initialize a TypeScript project
cdktf init --template=typescript --providers=aws
```

```typescript
// main.ts
import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", { region: "us-east-1" });

    new S3Bucket(this, "MyBucket", {
      bucket: "my-cdktf-bucket",
    });
  }
}

const app = new App();
new MyStack(app, "my-stack");
app.synth();
```

```bash
cdktf plan
cdktf deploy
```

---

### 5. Testing with Terratest

Terratest is a Go library for writing automated tests for infrastructure code.

```go
// test/vpc_test.go
package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestVpcModule(t *testing.T) {
    t.Parallel()

    opts := &terraform.Options{
        TerraformDir: "../modules/vpc",
        Vars: map[string]interface{}{
            "vpc_cidr": "10.0.0.0/16",
            "name":     "test-vpc",
        },
    }

    // Destroy resources after test
    defer terraform.Destroy(t, opts)

    terraform.InitAndApply(t, opts)

    vpcId := terraform.Output(t, opts, "vpc_id")
    assert.NotEmpty(t, vpcId)
}
```

```bash
go test -v -timeout 30m ./test/
```

---

### 6. Native TF Tests (1.6+)

Terraform 1.6 introduced a built-in testing framework using `.tftest.hcl` files.

```hcl
# tests/vpc.tftest.hcl
run "creates_vpc_with_correct_cidr" {
  command = apply

  variables {
    vpc_cidr = "10.0.0.0/16"
    name     = "test-vpc"
  }

  assert {
    condition     = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block does not match the expected value"
  }
}

run "validates_tags" {
  command = plan

  assert {
    condition     = aws_vpc.main.tags["Environment"] != ""
    error_message = "Environment tag must not be empty"
  }
}
```

```bash
terraform test
```

---

### 7. Policy as Code

Enforce organizational standards before `terraform apply`.

#### Open Policy Agent (OPA) + Conftest

```rego
# policy/main.rego
package main

deny[msg] {
    r := input.resource_changes[_]
    r.type == "aws_s3_bucket"
    not r.change.after.tags["Environment"]
    msg := sprintf("S3 bucket '%s' must have an Environment tag", [r.address])
}
```

```bash
terraform plan -out=tfplan
terraform show -json tfplan > plan.json
conftest test plan.json --policy policy/
```

#### Sentinel (Terraform Cloud / Enterprise)

```python
# policy/require-tags.sentinel
import "tfplan/v2" as tfplan

required_tags = ["Environment", "Owner", "CostCenter"]

main = rule {
  all tfplan.resource_changes as _, changes {
    all required_tags as tag {
      changes.change.after.tags[tag] is not null
    }
  }
}
```

---

### 8. State Manipulation

Use state commands carefully — always back up state before manipulation.

```bash
# List all resources in state
terraform state list

# Show details of a specific resource
terraform state show aws_instance.web

# Rename a resource in state (after renaming in .tf file)
terraform state mv aws_instance.old_name aws_instance.new_name

# Move a resource into a module
terraform state mv aws_instance.web module.compute.aws_instance.web

# Remove a resource from state (does not destroy the real resource)
terraform state rm aws_instance.web

# Pull remote state to a local file
terraform state pull > backup.tfstate

# Push a local state file to remote backend
terraform state push backup.tfstate
```

---

### 9. Multi-Account Scale

#### Assume Role Pattern (AWS)

```hcl
provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::PROD_ACCOUNT_ID:role/TerraformRole"
    session_name = "terraform-prod"
  }
}

resource "aws_vpc" "prod_vpc" {
  provider   = aws.prod
  cidr_block = "10.0.0.0/16"
}
```

#### Account Vending with Terraform

```
org/
├── management/          # Creates sub-accounts via AWS Organizations
│   └── main.tf
├── shared-services/     # DNS, logging, security tooling
│   └── main.tf
└── workloads/
    ├── dev/
    └── prod/
```

---

### 10. Drift Detection

Detect when real infrastructure has diverged from Terraform state.

```bash
# Manual drift check — returns non-zero exit if drift detected
terraform plan -detailed-exitcode
# Exit code 0: No changes
# Exit code 1: Error
# Exit code 2: Changes detected (drift)
```

#### Scheduled Drift Detection (GitHub Actions)

```yaml
name: Drift Detection

on:
  schedule:
    - cron: "0 8 * * 1-5"   # Weekdays at 8am

jobs:
  drift-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Terraform Plan (Drift Check)
        run: terraform plan -detailed-exitcode
        continue-on-error: true
      - name: Notify on Drift
        if: steps.plan.outcome == 'failure'
        run: echo "Drift detected — alert the team!"
```

---

### 11. Refactoring Blocks

Safely rename or move resources without destroying and recreating them.

#### `moved` Block (Terraform 1.1+)

```hcl
# After renaming aws_instance.old to aws_instance.web in main.tf
moved {
  from = aws_instance.old
  to   = aws_instance.web
}
```

#### Moving into a Module

```hcl
moved {
  from = aws_instance.web
  to   = module.compute.aws_instance.web
}
```

#### `removed` Block (Terraform 1.7+)

```hcl
# Remove from state without destroying the real resource
removed {
  from = aws_instance.legacy
  lifecycle {
    destroy = false
  }
}
```

---

### 12. Advanced Deployments

#### Blue/Green with `create_before_destroy`

```hcl
resource "aws_launch_template" "app" {
  name_prefix   = "app-"
  image_id      = var.ami_id
  instance_type = "t3.medium"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  min_size         = 2
  max_size         = 10
  desired_capacity = 3

  lifecycle {
    create_before_destroy = true
  }
}
```

---

### 13. Advanced Checklist

- [ ] Build a full CI/CD pipeline with plan-on-PR and apply-on-merge
- [ ] Set up Atlantis for GitOps-based Terraform automation
- [ ] Write Terratest integration tests for a module
- [ ] Write native `.tftest.hcl` tests using `terraform test`
- [ ] Enforce tagging policies with Conftest/OPA or Sentinel
- [ ] Use `terraform state mv` to safely rename a resource
- [ ] Set up scheduled drift detection in CI
- [ ] Use `moved` blocks to refactor module structure without destroying resources
- [ ] Configure cross-account role assumption for multi-account deployments
- [ ] Implement `create_before_destroy` for zero-downtime deployments

---

## 🔴 Expert Level

> **Goal:** Design, scale, and govern Terraform as a platform across multiple teams and hundreds of accounts.
> **Estimated Time:** Ongoing — shaped by production experience

---

### 1. Platform Engineering

Build an Internal Developer Platform (IDP) around Terraform so application teams can self-serve infrastructure.

```
Platform Engineering Team
        │
        ▼
┌───────────────────────────────┐
│  Internal Module Registry     │  ← versioned, opinionated modules
│  Golden Path Templates        │  ← scaffolded starters
│  CI/CD Pipeline Templates     │  ← standardized apply workflows
│  Policy Library (OPA/Sentinel)│  ← guardrails
└───────────────────────────────┘
        │
        ▼
Application Teams (self-service)
```

**Key responsibilities:**
- Maintain versioned, opinionated Terraform modules (golden paths)
- Provide scaffolding tools so teams can start new services in minutes
- Enforce guardrails via policy-as-code (not gatekeeping humans)
- Manage the state backend and access control centrally

---

### 2. Terragrunt

Terragrunt is a thin wrapper around Terraform that solves DRY configuration at scale.

```
infrastructure/
├── terragrunt.hcl          # Root config (backend, provider defaults)
├── _envcommon/
│   └── vpc.hcl             # Shared defaults for the VPC module
├── dev/
│   ├── terragrunt.hcl      # Env-level settings
│   └── vpc/
│       └── terragrunt.hcl  # Calls module, inherits root + env config
└── prod/
    ├── terragrunt.hcl
    └── vpc/
        └── terragrunt.hcl
```

```hcl
# prod/vpc/terragrunt.hcl
include "root" {
  path = find_in_parent_folders()
}

include "vpc" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/vpc.hcl"
}

inputs = {
  vpc_cidr = "10.1.0.0/16"
  name     = "prod-vpc"
}
```

```bash
# Deploy all modules in dependency order
terragrunt run-all apply

# Plan all modules
terragrunt run-all plan

# Deploy only changed modules
terragrunt run-all apply --terragrunt-ignore-external-dependencies
```

---

### 3. Ecosystem & Alternatives

| Tool | Language | Philosophy | Best For |
|------|----------|------------|----------|
| **Terraform** | HCL | Declarative, provider-based | General-purpose IaC |
| **OpenTofu** | HCL | Terraform fork, open-source | Same as TF, open governance |
| **Pulumi** | Python, TS, Go, C# | Imperative, uses real code | Complex logic, existing code teams |
| **Crossplane** | YAML / Go | Kubernetes-native IaC | Platform teams already on K8s |
| **Ansible** | YAML | Procedural, agentless | Config management, not ideal for IaC |
| **AWS CDK** | TS, Python, etc. | AWS-only, code-first | AWS-only shops |
| **CloudFormation** | YAML/JSON | AWS-native | Teams requiring native AWS support |

---

### 4. OpenTofu

OpenTofu is the open-source fork of Terraform created after HashiCorp changed Terraform's license to BSL 1.1 in 2023.

```bash
# Install OpenTofu
brew install opentofu

# Or via official installer
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh | sh

# Drop-in compatible with Terraform
tofu init
tofu plan
tofu apply
```

**Key differences from Terraform:**

| Feature | Terraform (BSL) | OpenTofu (MPL 2.0) |
|---------|-----------------|---------------------|
| License | BSL 1.1 | MPL 2.0 (fully open-source) |
| Governance | HashiCorp | Linux Foundation / CNCF |
| State encryption | Planned | Shipped (1.7) |
| Provider-level mock testing | Roadmap | Shipped (1.7) |

---

### 5. Private Module Registry

Host your own module registry for internal use.

#### Terraform Cloud / Enterprise (Built-in)

```hcl
module "vpc" {
  source  = "app.terraform.io/my-org/vpc/aws"
  version = "2.1.0"
}
```

#### Self-Hosted with Terraform Registry Protocol

Implement the [Module Registry Protocol](https://developer.hashicorp.com/terraform/internals/module-registry-protocol) on any HTTPS server. Minimal requirements:

```
GET /.well-known/terraform.json
GET /v1/modules/{namespace}/{name}/{provider}/versions
GET /v1/modules/{namespace}/{name}/{provider}/{version}/download
```

#### GitLab Terraform Module Registry

```bash
# Publish a module to GitLab
curl --header "JOB-TOKEN: $CI_JOB_TOKEN" \
     --upload-file ./module.tar.gz \
     "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/packages/terraform/modules/vpc/aws/1.0.0/file"
```

---

### 6. Security at Depth

#### Principle of Least Privilege for CI/CD

```hcl
# Grant CI/CD role only what it needs — nothing more
resource "aws_iam_role_policy" "terraform_ci" {
  name = "terraform-ci-policy"
  role = aws_iam_role.terraform_ci.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:*", "s3:*", "rds:*"]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}
```

#### OIDC Authentication (No Long-Lived Credentials)

```hcl
# Allow GitHub Actions to assume an AWS role via OIDC
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-terraform"

  assume_role_policy = jsonencode({
    Statement = [{
      Effect    = "Allow"
      Principal = { Federated = aws_iam_openid_connect_provider.github.arn }
      Action    = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:my-org/my-repo:*"
        }
      }
    }]
  })
}
```

---

### 7. Static Analysis

Integrate these tools into your CI pipeline to catch issues before apply.

| Tool | Purpose | Config File |
|------|---------|-------------|
| **tflint** | Linting, provider-specific rules | `.tflint.hcl` |
| **tfsec** | Security scanning | N/A (opinionated) |
| **checkov** | Security & compliance | N/A (opinionated) |
| **trivy** | Misconfiguration, CVE scanning | N/A |
| **terrascan** | Policy compliance | `terrascan.toml` |
| **infracost** | Cost estimation | `.infracost/` |

```bash
# tflint
tflint --init
tflint --recursive

# tfsec
tfsec .

# checkov
checkov -d . --framework terraform

# trivy (IaC scanning)
trivy config .

# infracost
infracost breakdown --path .
infracost diff --path . --compare-to baseline.json
```

---

### 8. Terraform Cloud / Enterprise

| Feature | Terraform Cloud (Free) | Terraform Cloud (Plus) | TFE (Self-hosted) |
|---------|----------------------|----------------------|-------------------|
| Remote runs | ✅ | ✅ | ✅ |
| State management | ✅ | ✅ | ✅ |
| Private registry | ✅ | ✅ | ✅ |
| SSO | ❌ | ✅ | ✅ |
| Audit logging | ❌ | ✅ | ✅ |
| Sentinel policies | ❌ | ✅ | ✅ |
| Agent pools | ❌ | ✅ | ✅ |
| Air-gapped install | ❌ | ❌ | ✅ |

---

### 9. Module Composition Patterns

#### Opinionated Wrapper Module

```hcl
# modules/opinionated-vpc/main.tf
# Wraps the community module with company defaults
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  # Hardcoded company defaults
  enable_flow_log                      = true
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  manage_default_network_acl           = true
  manage_default_route_table           = true
  manage_default_security_group        = true

  # Passed through from caller
  name   = var.name
  cidr   = var.vpc_cidr
  azs    = var.azs
}
```

#### Layered Architecture

```
Layer 0: Bootstrap  (S3 backend, DynamoDB, IAM roles for Terraform)
Layer 1: Networking (VPC, subnets, TGW, DNS)
Layer 2: Platform   (EKS, RDS, ElastiCache)
Layer 3: Workloads  (Application deployments on top of platform)
```

Each layer reads state from the layer below using `terraform_remote_state`.

---

### 10. Contributing to OSS

- **Terraform Core:** [github.com/hashicorp/terraform](https://github.com/hashicorp/terraform)
- **OpenTofu:** [github.com/opentofu/opentofu](https://github.com/opentofu/opentofu)
- **Community Providers:** [registry.terraform.io](https://registry.terraform.io/browse/providers)
- **Terraform AWS Modules:** [github.com/terraform-aws-modules](https://github.com/terraform-aws-modules)

**How to contribute:**

1. Find a `good first issue` in the repository
2. Read the contribution guide (`CONTRIBUTING.md`)
3. Write code and tests following the project conventions
4. Open a PR with a clear description and linked issue

---

### 11. TF Associate Certification

**HashiCorp Terraform Associate (003)** — the industry-standard Terraform certification.

**Exam Domains:**

| Domain | Weight |
|--------|--------|
| Understand IaC concepts | ~7% |
| Understand Terraform purpose | ~7% |
| Understand Terraform basics | ~25% |
| Use Terraform outside the core workflow | ~25% |
| Interact with Terraform modules | ~17% |
| Use the core Terraform workflow | ~13% |
| Implement Terraform state | ~6% |

**Study Resources:**
- [Official Study Guide](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-study-003)
- [HashiCorp Learn Tutorials](https://developer.hashicorp.com/terraform/tutorials)
- [Sample Questions](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-questions)

```bash
# Hands-on prep: complete all tutorials in these collections
# 1. Get Started (AWS/Azure/GCP)
# 2. Configuration Language
# 3. Modules
# 4. Manage Terraform State
# 5. Terraform Cloud
```

---

### 12. FinOps & Cost Control

Track and optimize cloud costs directly from your IaC pipeline.

#### Infracost in CI

```yaml
# .github/workflows/infracost.yml
- name: Setup Infracost
  uses: infracost/actions/setup@v3
  with:
    api-key: ${{ secrets.INFRACOST_API_KEY }}

- name: Generate cost estimate
  run: |
    infracost breakdown --path . \
      --format json \
      --out-file /tmp/infracost-base.json

- name: Post cost comment on PR
  uses: infracost/actions/comment@v3
  with:
    path: /tmp/infracost-base.json
    behavior: update
```

#### Tagging Strategy for Cost Allocation

```hcl
# In your root module, enforce mandatory tags on all resources
locals {
  mandatory_tags = {
    Team        = var.team
    CostCenter  = var.cost_center
    Environment = var.environment
    ManagedBy   = "terraform"
    Repo        = var.repo_url
  }
}

resource "aws_instance" "web" {
  # ...
  tags = merge(local.mandatory_tags, var.additional_tags)
}
```

---

### 13. Expert Checklist

- [ ] Build an internal module registry with versioned golden-path modules
- [ ] Set up Terragrunt `run-all` across 10+ environments
- [ ] Implement OIDC-based CI/CD auth (no long-lived AWS keys)
- [ ] Write a custom Terraform provider using the Plugin Framework
- [ ] Deploy infrastructure across 3+ AWS accounts using assume-role
- [ ] Integrate tflint, tfsec, checkov, and infracost into CI
- [ ] Implement OPA/Sentinel policies to enforce mandatory tagging
- [ ] Set up scheduled drift detection with alerting
- [ ] Migrate a large codebase from flat config to a layered module architecture
- [ ] Publish a module to the Terraform public or private registry
- [ ] Configure Terraform Cloud agents for private network access
- [ ] Pass the HashiCorp Terraform Associate (003) exam

---

## 🧪 Real-World Projects

### Beginner Projects

| Project | Skills Practiced |
|---------|-----------------|
| **Provision an S3 static website** | Provider setup, resources, outputs |
| **Deploy an EC2 instance with SSH** | Variables, key pairs, security groups |
| **Create an Azure Resource Group + VNet** | Azure provider, basic networking |
| **GCP Cloud Storage bucket lifecycle** | GCP provider, lifecycle rules |

### Intermediate Projects

| Project | Skills Practiced |
|---------|-----------------|
| **3-tier VPC (public/private/DB subnets)** | Networking, modules, for_each |
| **ECS Fargate service with ALB** | Compute, load balancing, secrets |
| **RDS with read replica and automated backup** | StatefulDB, PVC-like patterns |
| **Multi-env infrastructure (dev/staging/prod)** | Workspaces, tfvars, remote state |

### Advanced Projects

| Project | Skills Practiced |
|---------|-----------------|
| **Full CI/CD pipeline with Atlantis** | GitOps, PR workflows, locking |
| **EKS cluster with node groups and IRSA** | Complex module, IAM, OIDC |
| **Multi-region active-active setup** | Provider aliases, DR patterns |
| **Policy-gated pipeline with OPA/Sentinel** | Policy-as-code, compliance |

### Expert-Level Projects

| Project | Skills Practiced |
|---------|-----------------|
| **Internal developer platform with self-service** | Platform engineering, IDP |
| **AWS Landing Zone with account vending** | Organizations, SCPs, multi-account |
| **Custom Terraform provider for internal API** | Plugin Framework, Go, testing |
| **Cost-aware IaC pipeline with Infracost gates** | FinOps, PR automation |

---

## 📚 Learning Resources

### Official Documentation

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs) — Language, CLI, providers
- [OpenTofu Docs](https://opentofu.org/docs/) — Open-source fork documentation
- [Terraform Registry](https://registry.terraform.io) — Providers and modules
- [HashiCorp Learn](https://developer.hashicorp.com/terraform/tutorials) — Guided tutorials

### Books

| Title | Author | Level |
|-------|--------|-------|
| *Terraform: Up & Running* | Yevgeniy Brikman | Beginner–Advanced |
| *Infrastructure as Code* | Kief Morris | Beginner–Intermediate |
| *Terraform in Action* | Scott Winkler | Intermediate |
| *Cloud Native Infrastructure* | Justin Garrison & Kris Nova | Advanced |

### Hands-On Labs

- [HashiCorp Learn Tutorials](https://developer.hashicorp.com/terraform/tutorials) — Free, browser-based
- [A Cloud Guru / Pluralsight](https://acloudguru.com) — Structured labs with cloud sandboxes
- [KodeKloud](https://kodekloud.com/courses/terraform/) — Hands-on Terraform course with labs
- [Instruqt](https://play.instruqt.com/hashicorp) — HashiCorp's interactive learning platform

### Video Courses

| Course | Platform | Level |
|--------|----------|-------|
| HashiCorp Terraform Associate Prep | Udemy (Zeal Vora) | Beginner–Intermediate |
| Terraform Deep Dive | Pluralsight | Intermediate |
| Complete Terraform Course | freeCodeCamp (YouTube) | Beginner |
| Terraform with AWS — Full Course | TechWorld with Nana | Beginner–Intermediate |

---

## 🏆 Certification Path

```
Entry Level                    Professional Level
┌─────────────────────┐        ┌──────────────────────────────────┐
│  Terraform Associate│──────► │  (No official advanced cert yet) │
│         (003)       │        │  Contribute to ecosystem instead  │
└─────────────────────┘        └──────────────────────────────────┘
```

### HashiCorp Terraform Associate (003)

| Detail | Info |
|--------|------|
| **Exam Duration** | 1 hour |
| **Question Format** | ~57 multiple-choice / multiple-select |
| **Passing Score** | ~70% |
| **Cost** | $70.50 USD |
| **Validity** | 2 years |
| **Recommended Experience** | 6+ months hands-on |
| **Exam Guide** | [developer.hashicorp.com](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-study-003) |

---

## 🗺️ Complete Learning Path Summary

```
Week 1–4    ─── 🟢 Beginner ───────────────────────────────────────────
                Install Terraform → HCL syntax → first plan/apply
                Resources, variables, outputs, state → meta-arguments

Week 4–12   ─── 🔵 Intermediate ───────────────────────────────────────
                Modules → remote state → workspaces
                Functions, loops, dynamic blocks → secrets management
                Multi-env patterns → import → data sources

Week 12–22  ─── 🟠 Advanced ────────────────────────────────────────────
                CI/CD pipelines → Atlantis GitOps
                Custom providers → CDKTF → Terratest → native tests
                Policy as Code → state manipulation → drift detection

Ongoing     ─── 🔴 Expert ──────────────────────────────────────────────
                Platform engineering → Terragrunt at scale
                OpenTofu → private registry → security depth
                FinOps → TF Associate cert → OSS contributions
```

---

*Last updated: 2025 · Community contributions welcome*