#!/bin/bash
# ========================================
# KamaNotes Docker 启动脚本
# ========================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  KamaNotes Docker 部署${NC}"
echo -e "${GREEN}========================================${NC}"

# 检查 .env 文件
if [ ! -f .env ]; then
    echo -e "${YELLOW}未找到 .env 文件，正在从 env.example 创建...${NC}"
    cp env.example .env
    echo -e "${YELLOW}请修改 .env 文件中的配置后重新运行此脚本${NC}"
    exit 1
fi

# 检查 SQL 初始化文件
if [ ! -f init-db/kamanote-tech.sql ] && [ ! -f init-db/01-schema.sql ]; then
    echo -e "${YELLOW}警告: init-db 目录中未找到 SQL 初始化文件${NC}"
    echo -e "${YELLOW}请将 kamanote-tech.sql 放入 init-db 目录${NC}"
fi

# 解析参数
ACTION=${1:-up}

case $ACTION in
    up)
        echo -e "${GREEN}启动所有服务...${NC}"
        docker-compose up -d --build
        echo -e "${GREEN}服务已启动!${NC}"
        echo -e "${GREEN}前端: http://localhost:80${NC}"
        echo -e "${GREEN}后端: http://localhost:8080${NC}"
        ;;
    down)
        echo -e "${YELLOW}停止所有服务...${NC}"
        docker-compose down
        ;;
    restart)
        echo -e "${YELLOW}重启所有服务...${NC}"
        docker-compose restart
        ;;
    logs)
        docker-compose logs -f ${2:-}
        ;;
    clean)
        echo -e "${RED}警告: 这将删除所有数据卷!${NC}"
        read -p "确定要继续吗? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker-compose down -v
            echo -e "${GREEN}已清理所有容器和数据卷${NC}"
        fi
        ;;
    *)
        echo "用法: $0 {up|down|restart|logs|clean}"
        echo "  up      - 启动所有服务"
        echo "  down    - 停止所有服务"
        echo "  restart - 重启所有服务"
        echo "  logs    - 查看日志 (可选服务名: backend/frontend/mysql/redis)"
        echo "  clean   - 停止服务并删除数据卷"
        exit 1
        ;;
esac
