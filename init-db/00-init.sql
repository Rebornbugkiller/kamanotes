-- ========================================
-- KamaNotes 数据库初始化脚本
-- ========================================

-- 确保使用正确的数据库
USE kamanote_tech;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ========================================
-- 请将你的 kamanote-tech.sql 内容放在下方
-- 或者将 kamanote-tech.sql 重命名为 01-schema.sql 放入此目录
-- ========================================

-- 示例：用户表
-- CREATE TABLE IF NOT EXISTS `user` (
--     `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
--     `username` VARCHAR(50) NOT NULL COMMENT '用户名',
--     `password` VARCHAR(255) NOT NULL COMMENT '密码',
--     `email` VARCHAR(100) COMMENT '邮箱',
--     `avatar` VARCHAR(255) COMMENT '头像URL',
--     `role` VARCHAR(20) DEFAULT 'user' COMMENT '角色',
--     `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
--     `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
--     PRIMARY KEY (`id`),
--     UNIQUE KEY `uk_username` (`username`),
--     UNIQUE KEY `uk_email` (`email`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
