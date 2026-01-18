# ========================================
# KamaNotes Docker 启动脚本 (PowerShell)
# ========================================

param(
    [Parameter(Position=0)]
    [ValidateSet("up", "down", "restart", "logs", "clean", "status")]
    [string]$Action = "up",
    
    [Parameter(Position=1)]
    [string]$Service = ""
)

$ProjectDir = Split-Path -Parent $PSScriptRoot
Set-Location $ProjectDir

function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "  KamaNotes Docker 部署" -ForegroundColor Green  
Write-Host "========================================" -ForegroundColor Green

# 检查 .env 文件
if (-not (Test-Path ".env")) {
    Write-Host "未找到 .env 文件，正在从 env.example 创建..." -ForegroundColor Yellow
    Copy-Item "env.example" ".env"
    Write-Host "请修改 .env 文件中的配置后重新运行此脚本" -ForegroundColor Yellow
    exit 1
}

# 检查 SQL 初始化文件
if (-not (Test-Path "init-db/kamanote-tech.sql") -and -not (Test-Path "init-db/01-schema.sql")) {
    Write-Host "警告: init-db 目录中未找到 SQL 初始化文件" -ForegroundColor Yellow
    Write-Host "请将 kamanote-tech.sql 放入 init-db 目录" -ForegroundColor Yellow
}

switch ($Action) {
    "up" {
        Write-Host "启动所有服务..." -ForegroundColor Green
        docker-compose up -d --build
        Write-Host ""
        Write-Host "服务已启动!" -ForegroundColor Green
        Write-Host "前端: http://localhost:80" -ForegroundColor Cyan
        Write-Host "后端: http://localhost:8080" -ForegroundColor Cyan
    }
    "down" {
        Write-Host "停止所有服务..." -ForegroundColor Yellow
        docker-compose down
    }
    "restart" {
        Write-Host "重启所有服务..." -ForegroundColor Yellow
        docker-compose restart
    }
    "logs" {
        if ($Service) {
            docker-compose logs -f $Service
        } else {
            docker-compose logs -f
        }
    }
    "status" {
        docker-compose ps
    }
    "clean" {
        Write-Host "警告: 这将删除所有数据卷!" -ForegroundColor Red
        $confirm = Read-Host "确定要继续吗? (y/N)"
        if ($confirm -eq "y" -or $confirm -eq "Y") {
            docker-compose down -v
            Write-Host "已清理所有容器和数据卷" -ForegroundColor Green
        }
    }
    default {
        Write-Host "用法: .\docker-start.ps1 {up|down|restart|logs|status|clean} [service]"
        Write-Host "  up      - 启动所有服务"
        Write-Host "  down    - 停止所有服务"
        Write-Host "  restart - 重启所有服务"
        Write-Host "  logs    - 查看日志 (可选服务名: backend/frontend/mysql/redis)"
        Write-Host "  status  - 查看服务状态"
        Write-Host "  clean   - 停止服务并删除数据卷"
    }
}
