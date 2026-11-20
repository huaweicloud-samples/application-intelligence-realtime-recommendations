# Real-Time Recommendation Engine: Huawei Cloud Best Practice

[中文版](./README.cn.md)

![License](https://img.shields.io/badge/license-MIT--0-blue.svg)
![Huawei Cloud](https://img.shields.io/badge/华为云-最佳实践-ff4d00.svg)

> Huawei Cloud Best Practice

---

## Overview

This project is a complete real-time recommendation engine solution implemented on Huawei Cloud ModelArts, landing the same-shaped architecture of industry feature-store and real-time recommendation systems. The solution demonstrates how to build enterprise-grade real-time recommendation systems on the cloud, covering the entire process from feature engineering to model training to online inference.

### Project Background

Recommendation systems are core components of internet applications such as e-commerce, content platforms, and social networks. Traditional batch processing recommendation systems suffer from high data latency and inability to respond to user behavior in real-time. This project adopts a streaming processing architecture, achieving true real-time recommendation capabilities that can immediately update recommendation results based on user behavior, significantly improving user experience and conversion rates.

### Core Technical Capabilities

1. **Feature Storage and Management** - Following industry feature-store design principles, building a unified feature storage layer on Huawei Cloud. Feature storage supports two types of offline and real-time features: offline features for model training, storing historical data in bulk through OBS; real-time features for online inference, receiving user behavior data in real-time through DIS. Feature storage also provides feature version management and feature lineage tracking, ensuring consistent features for model training and inference.

2. **Collaborative Filtering Models** - Implements both user-based and item-based collaborative filtering algorithms. Collaborative filtering models can discover potential relationships between users and items without explicit feature engineering, generating recommendation results. This model is suitable for cold start scenarios, providing reasonable recommendations when new users or items lack historical data. Model training is completed on ModelArts, supporting distributed training and automatic hyperparameter tuning.

3. **Ranking Models** - Uses XGBoost and FM (Factorization Machines) to build a two-stage recommendation system ranking model. The ranking model receives candidate item lists, performing precise ranking based on multi-dimensional features such as user profiles, item features, and context information. FM models can automatically learn feature cross-relationships, while XGBoost provides powerful tree model expression capabilities, combining to achieve high-precision recommendation ranking.

4. **Real-time Inference Service** - Models deployed on ModelArts' online inference service, providing low-latency recommendation interfaces. Real-time inference services support A/B testing and multi-version model comparison, allowing online adjustment of recommendation strategies without redeployment. The inference service also implements recommendation result caching and batch request optimization to further reduce response latency.

5. **Streaming Data Processing** - Uses DIS (Data Ingestion Service) and Flink to implement end-to-end streaming processing pipelines. User behavior data (such as clicks, views, favorites, etc.) is ingested in real-time through DIS, cleaned and aggregated by Flink, then written to feature storage and real-time recommendation engines. The entire processing pipeline latency is controlled at the second level, ensuring the timeliness of recommendation results.

### Application Scenarios

- **E-commerce Product Recommendations**: Real-time product recommendations based on user browsing and purchase history
- **Content Platform Recommendations**: Recommending articles, videos, and other content of interest to users
- **Advertising Recommendations**: Precise personalized advertising placement to improve ad click-through rates
- **Social Network Recommendations**: Recommending people users may know, topics of interest, etc.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Huawei Cloud Architecture                        │
├─────────────────────────────────────────────────────────────────────┤
│  OBS ──▶ ModelArts Training ──▶ FM + XGBoost Models           │
│                              │                                    │
│    ┌──────────┬──────────┬──┼──┬──────────┬──────────┐        │
│    ▼          ▼          ▼  ▼  ▼          ▼          ▼          │
│  DIS ──▶ Flink ──▶ RDS MySQL ──▶ Real-time Inference         │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Services

| Service | Purpose |
|---------|---------|
| ModelArts | ML Training & Inference |
| DIS | Stream Data Ingestion |
| Flink | Stream Aggregation |
| RDS MySQL | Online Feature Store |
| OBS | Offline Feature Store |
| KMS | Key Management |

---

## Quick Start

```bash
cd infra
terraform init
terraform apply
```

---

## License

MIT-0 License
