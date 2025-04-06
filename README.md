### fargate-wp-terraform 

### 構成概要
以下のリソースをTerraformにより構築します。
・VPC（2AZ）
・Public/Private Subnet
・ECS Cluster（Fargate）
・ALB
・Route53
・CloudFront   
・RDS（MySQL）

### 前提条件
・AWSアカウント
・ドメイン
・Terraform
・Docker
・AWS CLI（認証済み）
・ECRリポジトリ

### 機能と今後の展望
・CI/CD パイプライン導入済み（GitHub Actions による自動デプロイ）
・HTTPS 対応（CloudFront + ACM）
・将来的に Helm や EKS への対応も検討中