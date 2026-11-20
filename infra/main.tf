# ============================================================================
# 华为云 实时推荐引擎 Terraform 配置
# ============================================================================
# 实时特征存储与推荐系统
# ============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.70"
    }
  }
}

provider "huaweicloud" {
  region = var.region
}

variable "region" {
  description = "华为云区域"
  type        = string
  default     = "cn-north-4"
}

variable "project_name" {
  description = "项目名称"
  type        = string
  default     = "realtime-rec"
}

# ============================================================================
# Layer 1: VPC 网络
# ============================================================================

resource "huaweicloud_vpc" "main" {
  name                  = "${var.project_name}-vpc"
  cidr                  = "10.5.0.0/16"
  enterprise_project_id = "0"
}

resource "huaweicloud_vpc_subnet" "main" {
  name       = "${var.project_name}-subnet"
  vpc_id     = huaweicloud_vpc.main.id
  cidr       = "10.5.1.0/24"
  gateway_ip = "10.5.1.1"
}

# ============================================================================
# Layer 2: 安全组
# ============================================================================

resource "huaweicloud_networking_secgroup" "main" {
  name        = "${var.project_name}-sg"
  description = "Security group for recommendation engine"
}

# ============================================================================
# Layer 3: OBS (离线特征存储)
# ============================================================================

resource "huaweicloud_obs_bucket" "features" {
  bucket     = "${var.project_name}-features"
  acl        = "private"
  storage_class = "STANDARD"
}

resource "huaweicloud_obs_bucket" "models" {
  bucket     = "${var.project_name}-models"
  acl        = "private"
  storage_class = "STANDARD"
}

# ============================================================================
# Layer 4: KMS
# ============================================================================

resource "huaweicloud_kms_key" "main" {
  key_alias        = "${var.project_name}-cmk"
  key_description = "KMS key for recommendation engine"
  key_algorithm  = "AES_256"
}

# ============================================================================
# 输出
# ============================================================================

output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.main.id
}

output "obs_buckets" {
  description = "OBS Bucket Names"
  value = {
    features = huaweicloud_obs_bucket.features.bucket
    models   = huaweicloud_obs_bucket.models.bucket
  }
}

# ============================================================================
# 说明
# ============================================================================
#
# 以下资源需要通过控制台或 API 创建：
#
# 1. DIS - 实时流数据接入
# 2. Flink - 流数据分析
# 3. GeminiDB - 在线特征存储
# 4. ModelArts - ML 训练和推理
#
# ============================================================================
