# 构建阶段
FROM node:20.18-alpine AS build

WORKDIR /app

# 先复制依赖文件利用 Docker 缓存
COPY package.json package-lock.json ./

# 安装依赖
RUN npm ci --registry=https://registry.npmmirror.com

# 复制源代码
COPY . .

# 明确设置环境变量为空，确保使用相对路径
ENV VITE_API_BASE_URL=""

# 构建生产版本
RUN npm run build

# 运行阶段
FROM nginx:stable-alpine

# 复制构建产物
COPY --from=build /app/dist /usr/share/nginx/html

# 复制 nginx 配置
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
