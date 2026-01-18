# 📝 KamaNotes (卡码笔记)

一个专为编程学习和算法练习设计的全栈笔记平台

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.18-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://reactjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.x-blue.svg)](https://www.typescriptlang.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-orange.svg)](https://www.mysql.com/)
[![Redis](https://img.shields.io/badge/Redis-Latest-red.svg)](https://redis.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 项目简介

KamaNotes 是一个功能完整的笔记平台,提供题目管理、笔记编辑、社交互动、智能搜索等功能。用户可以浏览编程题目、编写学习笔记、与其他用户交流,并通过统计数据追踪学习进度。

## 核心功能

### 📚 题目管理系统
- 按分类和难度浏览编程题目
- 支持题单和训练营组织形式
- 题目批量上传功能
- 题目统计和浏览记录

### ✍️ 笔记编辑与管理
- Markdown 富文本编辑器
- 代码语法高亮
- 笔记 CRUD 操作
- 笔记下载功能
- 笔记排行榜

### 💬 社交互动
- 评论系统(支持嵌套回复)
- 笔记点赞功能
- 笔记收藏功能
- 收藏夹管理
- 用户关注

### 🔍 智能搜索
- 笔记全文搜索
- 用户搜索
- 标签搜索
- 中文分词支持(Jieba)

### 📊 数据统计
- 用户活动热力图
- 笔记提交统计
- 学习进度追踪
- Top 排行榜

### 🔔 实时通知
- WebSocket 实时消息推送
- 消息已读/未读管理
- 消息分类展示

### 👥 用户系统
- 用户注册/登录
- 个人资料管理
- 头像上传
- 用户主页
- 权限管理(普通用户/管理员)

## 技术架构

### 后端技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| Spring Boot | 2.7.18 | 核心框架 |
| Spring Security | - | 安全框架 |
| MyBatis | 2.2.0 | 持久层框架 |
| MySQL | 8.0 | 关系型数据库 |
| Redis | - | 缓存数据库 |
| JWT | 0.9.1 | 身份认证 |
| WebSocket | - | 实时通信 |
| Flexmark | 0.64.8 | Markdown 处理 |
| Jieba | 1.0.2 | 中文分词 |
| Hutool | 5.8.25 | 工具库 |
| Log4j2 | - | 日志系统 |
| Thymeleaf | - | 邮件模板引擎 |

### 前端技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| React | 18.3.1 | UI 框架 |
| TypeScript | 5.6.2 | 类型系统 |
| Vite | 6.0.1 | 构建工具 |
| React Router | 6.28.0 | 路由管理 |
| Redux Toolkit | 2.4.0 | 状态管理 |
| Ant Design | 5.22.2 | UI 组件库 |
| TailwindCSS | 3.4.15 | CSS 框架 |
| Axios | 1.7.9 | HTTP 客户端 |
| Cherry Markdown | 0.8.55 | Markdown 编辑器 |
| Day.js | 1.11.13 | 日期处理 |

## 快速开始

### 环境要求

- Docker & Docker Compose
- JDK 17 (本地开发)
- Node.js 16+ (本地开发)
- MySQL 8.0
- Redis

### 使用 Docker Compose 部署(推荐)

1. 克隆项目
```bash
git clone https://github.com/Rebornbugkiller/kamanotes.git
cd kamanotes
```

2. 配置环境变量
```bash
cp env.example .env
# 编辑 .env 文件,配置数据库密码等信息
```

3. 启动服务
```bash
docker-compose up -d
```

4. 访问应用
- 前端地址: http://localhost:3000
- 后端 API: http://localhost:8080

### 本地开发部署

#### 后端启动

1. 配置数据库
```bash
# 创建数据库
mysql -u root -p < init-db/01-schema.sql
```

2. 修改配置文件
```bash
# 编辑 backend/src/main/resources/application.yaml
# 配置数据库连接、Redis 连接等信息
```

3. 启动后端服务
```bash
cd backend
mvn spring-boot:run
```

#### 前端启动

1. 安装依赖
```bash
cd frontend
npm install
```

2. 修改配置
```bash
# 编辑 frontend/src/base/constants.ts
# 配置后端 API 地址
```

3. 启动开发服务器
```bash
npm run dev
```

## 项目结构

```
kamanotes/
├── backend/                    # 后端项目
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/kama/notes/
│   │   │   │   ├── controller/      # 控制器层
│   │   │   │   ├── service/         # 业务逻辑层
│   │   │   │   ├── mapper/          # 数据访问层
│   │   │   │   ├── model/           # 数据模型
│   │   │   │   ├── config/          # 配置类
│   │   │   │   ├── filter/          # 过滤器
│   │   │   │   ├── interceptor/     # 拦截器
│   │   │   │   ├── exception/       # 异常处理
│   │   │   │   └── utils/           # 工具类
│   │   │   └── resources/
│   │   │       ├── application.yaml # 配置文件
│   │   │       └── mapper/          # MyBatis XML
│   │   └── test/                    # 测试代码
│   ├── Dockerfile
│   └── pom.xml
├── frontend/                   # 前端项目
│   ├── src/
│   │   ├── apps/              # 应用模块
│   │   │   ├── admin/         # 管理后台
│   │   │   └── user/          # 用户端
│   │   ├── domain/            # 业务领域
│   │   │   ├── user/          # 用户模块
│   │   │   ├── note/          # 笔记模块
│   │   │   ├── question/      # 题目模块
│   │   │   ├── comment/       # 评论模块
│   │   │   ├── message/       # 消息模块
│   │   │   └── ...
│   │   ├── base/              # 基础组件
│   │   ├── request/           # API 请求
│   │   └── store/             # 状态管理
│   ├── Dockerfile
│   └── package.json
├── init-db/                   # 数据库初始化脚本
│   ├── 01-schema.sql          # 表结构
│   └── 02-data.sql            # 初始数据
├── docker-compose.yml         # Docker 编排文件
├── env.example                # 环境变量示例
└── README.md
```

## 数据库设计

项目包含 14 张核心数据表:

- **user** - 用户表
- **category** - 分类表(支持层级)
- **question** - 题目表
- **question_list** - 题单表
- **question_list_item** - 题单-题目关联表
- **note** - 笔记表
- **comment** - 评论表
- **comment_like** - 评论点赞表
- **note_like** - 笔记点赞表
- **collection** - 收藏夹表
- **note_collect** - 笔记收藏表
- **collection_note** - 收藏夹-笔记关联表
- **message** - 消息表
- **statistic** - 统计表

## API 接口

### 用户相关
- `POST /api/user/register` - 用户注册
- `POST /api/user/login` - 用户登录
- `GET /api/user/info` - 获取用户信息
- `PUT /api/user/update` - 更新用户信息
- `POST /api/user/upload-avatar` - 上传头像

### 笔记相关
- `GET /api/note/list` - 获取笔记列表
- `GET /api/note/{id}` - 获取笔记详情
- `POST /api/note/create` - 创建笔记
- `PUT /api/note/update` - 更新笔记
- `DELETE /api/note/{id}` - 删除笔记
- `GET /api/note/download/{id}` - 下载笔记
- `GET /api/note/rank` - 笔记排行榜
- `GET /api/note/heatmap` - 活动热力图

### 评论相关
- `GET /api/comment/list` - 获取评论列表
- `POST /api/comment/create` - 创建评论
- `DELETE /api/comment/{id}` - 删除评论
- `POST /api/comment/like` - 点赞评论
- `POST /api/comment/unlike` - 取消点赞

### 搜索相关
- `GET /api/search/note` - 搜索笔记
- `GET /api/search/user` - 搜索用户
- `GET /api/search/tag` - 标签搜索

### 消息相关
- `GET /api/message/list` - 获取消息列表
- `PUT /api/message/read/{id}` - 标记已读
- `PUT /api/message/read-all` - 全部标记已读
- `GET /api/message/unread-count` - 未读消息数量

## 核心功能实现

### 搜索优化
- 使用 MySQL 全文索引提升搜索性能
- 集成 Jieba 分词器支持中文搜索
- 支持按标签、分类、用户等多维度搜索

### 缓存策略
- 使用 Redis 缓存热点数据
- 缓存用户信息、笔记列表等高频访问数据
- 实现缓存更新和失效机制

### 实时通信
- 基于 WebSocket 实现消息实时推送
- 支持评论通知、点赞通知、系统通知等
- 消息已读/未读状态管理

### 安全机制
- JWT Token 身份认证
- Spring Security 权限控制
- 密码加密存储
- XSS 和 SQL 注入防护

## 开发工具

- **IDE**: IntelliJ IDEA 2024.2.3
- **JDK**: Java 17
- **构建工具**: Maven
- **版本控制**: Git
- **API 测试**: APIfox
- **容器化**: Docker

## 贡献指南

欢迎提交 Issue 和 Pull Request 来改进项目。

## 许可证

MIT License

## 联系方式

如有问题或建议,欢迎通过 GitHub Issues 联系。
