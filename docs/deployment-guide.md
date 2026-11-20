# 部署指南：实时推荐引擎

## 概述

本文档说明如何在华为云上部署实时推荐引擎。

---

## 前置条件

1. 华为云账号（已开通以下服务）：
   - ModelArts (ML 训练)
   - DIS (实时流数据接入)
   - Flink (流分析)
   - RDS MySQL (在线特征)
   - OBS (离线特征)

---

## 部署步骤

### 步骤 1: 创建基础网络

```bash
cd infra
terraform init
terraform plan
terraform apply
```

### 步骤 2: 创建 DIS 流

通过控制台创建 DIS 流。

### 步骤 3: 创建 Flink 作业

通过控制台创建 Flink 作业，实现 2 分钟窗口聚合。

### 步骤 4: 创建 RDS MySQL

创建 RDS MySQL 实例用于在线特征存储。

### 步骤 5: 训练模型

使用 ModelArts 训练 FM 和 XGBoost 模型。

---

## 清理资源

```bash
terraform destroy
```

---


