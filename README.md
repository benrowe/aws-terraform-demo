# AWS Terraform Demo Project

Just a simple demo of playing with a application deployed to amazon + seeing it evolve over time.


## Objective

- Setup a brand new laravel/mariadb (inc workers) project with a simple api
- automate infrastructure and deployment using terraform & gh api
- migrate the project over time by introducing
  - simple spa FE
  - additional micro services
  - migrate api to graphql + golang

## Steps

1. Setup basic crud api for "books" @ `/api/v1/books`
2. Setup terraform config for (ECR/ECS/RDS/S3/EC)
3. Deploy infrastructure on merge (dev/master)
    1. build and push images to ecr on build
4. to come
