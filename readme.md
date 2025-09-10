# 📘 Serverless 3-Tier Architecture on AWS (Demo Project)

 🚀 Overview

This project demonstrates a serverless 3-tier application architecture on AWS using Terraform and a simple Python Lambda application.
It highlights a modern serverless approach (Cognito + API Gateway + Lambda + DynamoDB + S3 + CloudFront).

---

 🏗️ Architecture

# 1. Presentation Tier

* Amazon S3 → Static site hosting (frontend, e.g., React/HTML).
* Amazon CloudFront → CDN distribution for global caching and HTTPS (pending account verification).
* Amazon Cognito → Authentication via User Pool and User Pool Client.

# 2. Application Tier

* AWS Lambda → Python function for business logic.
* Amazon API Gateway (HTTP API v2) → Provides REST endpoints (`/items`) with:

  * Lambda proxy integration.
  * Cognito JWT Authorizer for authentication/authorization.

# 3. Data Tier

* Amazon DynamoDB → NoSQL table (`items`) with a simple hash key `id`.

  * Billing mode: `PAY_PER_REQUEST`.
  * Used to store application data (e.g., todo items).

---

 📂 Project Structure

```
3TierArch-AWS-serverless/
 ├── App/
 │    └── lambda/
 │    |     └── index.py        # Python Lambda handler
 |    └── static/
 │         └── index.html  
 │
 └── modules/
      ├── presentation/        # Presentation layer infra
      │    ├── s3.tf
      │    ├── cdn.tf
      │    └── cognito.tf
      │
      ├── business/            # Application logic layer
      │    ├── api.tf
      │    ├── lambda.tf
      │    └── iam.tf
      │
      └── data/                # Data layer infra
           └── dynamodb.tf

 ⚙️ Key Terraform Patterns

* Modules per tier (`presentation`, `business`, `data`) for separation of concerns.
* Outputs + variables used to connect tiers (e.g., Cognito outputs from `presentation` passed into `business` for API Gateway Authorizer).
* Best practices applied:

  * `aws_s3_bucket_acl` and `aws_s3_bucket_website_configuration` used instead of deprecated inline arguments.
  * Cognito JWT Authorizer with API Gateway HTTP API v2 requires `authorization_type = "JWT"`.
  * Avoiding ACLs for public buckets → using Bucket Policies instead.

---

 ✅ Features Implemented

* 🔐 Cognito User Pool + Client for authentication.
* ⚡ API Gateway HTTP API v2 + Lambda for serverless business logic.
* 🗄️ DynamoDB table for persistent storage.
* 🌍 S3 Static Website hosting (with plan to extend via CloudFront).
* 📦 Modular Terraform code (per tier).

---

 🧩 Issues & Resolutions

* S3 warnings → Fixed by migrating from deprecated `acl` & `website` arguments to `aws_s3_bucket_acl` + `aws_s3_bucket_website_configuration`.
* CloudFront AccessDenied → Blocked due to free-tier account not fully verified. Temporary solution: rely on S3 static hosting until AWS Support verification.
* API Gateway Authorizer error → Fixed by adding `authorization_type = "JWT"` to the secured route.
* ACL not supported error → Moved from ACLs to bucket policies.

---

 🔮 Next Steps

* Add CloudFront OAI (Origin Access Identity) or OAC (Origin Access Control) to secure S3 → CloudFront integration (once account verified).
* Configure Cognito Hosted UI or Amplify integration to provide a login page for end-users.
* Extend Lambda logic with more CRUD operations.
* Add CI/CD pipeline (GitHub Actions + Terraform + Lambda packaging).

---

 📌 Usage

1. Clone repo & configure AWS credentials.
2. Run:

   ```bash
   terraform init
   terraform apply -var-file="terraform.tfvars"
   ```
3. Upload static site files to S3 bucket.
4. Get API Gateway URL from Terraform output → test with valid Cognito JWT tokens.