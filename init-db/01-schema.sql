-- ========================================
-- KamaNotes 数据库建表脚本
-- 自动生成于项目实体类
-- ========================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 使用数据库
USE kamanote_tech;

-- ========================================
-- 1. 用户表
-- ========================================
CREATE TABLE IF NOT EXISTS `user` (
    `user_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `account` VARCHAR(50) NOT NULL COMMENT '账号（唯一）',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(255) NOT NULL COMMENT '加密后的登录密码',
    `gender` TINYINT DEFAULT 3 COMMENT '用户性别：1=男，2=女，3=保密',
    `birthday` DATE DEFAULT NULL COMMENT '用户生日',
    `avatar_url` VARCHAR(500) DEFAULT NULL COMMENT '头像地址',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '用户邮箱',
    `school` VARCHAR(100) DEFAULT NULL COMMENT '用户学校',
    `signature` VARCHAR(500) DEFAULT NULL COMMENT '用户签名',
    `is_banned` TINYINT DEFAULT 0 COMMENT '封禁状态：0=未封禁，1=已封禁',
    `is_admin` TINYINT DEFAULT 0 COMMENT '管理员状态：0=普通用户，1=管理员',
    `last_login_at` DATETIME DEFAULT NULL COMMENT '最后登录时间',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `uk_account` (`account`),
    UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ========================================
-- 2. 分类表
-- ========================================
CREATE TABLE IF NOT EXISTS `category` (
    `category_id` INT NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    `name` VARCHAR(100) NOT NULL COMMENT '分类名称',
    `parent_category_id` INT DEFAULT 0 COMMENT '上级分类ID，0表示一级分类',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`category_id`),
    KEY `idx_parent_category_id` (`parent_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

-- ========================================
-- 3. 问题表
-- ========================================
CREATE TABLE IF NOT EXISTS `question` (
    `question_id` INT NOT NULL AUTO_INCREMENT COMMENT '问题ID',
    `category_id` INT NOT NULL COMMENT '问题所属分类ID',
    `title` VARCHAR(500) NOT NULL COMMENT '问题标题',
    `difficulty` TINYINT DEFAULT 1 COMMENT '问题难度：1=简单，2=中等，3=困难',
    `exam_point` VARCHAR(500) DEFAULT NULL COMMENT '题目考点',
    `view_count` INT DEFAULT 0 COMMENT '浏览量',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`question_id`),
    KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='问题表';

-- ========================================
-- 4. 笔记表
-- ========================================
CREATE TABLE IF NOT EXISTS `note` (
    `note_id` INT NOT NULL AUTO_INCREMENT COMMENT '笔记ID',
    `author_id` BIGINT NOT NULL COMMENT '作者ID',
    `question_id` INT NOT NULL COMMENT '问题ID',
    `content` LONGTEXT COMMENT '笔记内容',
    `like_count` INT DEFAULT 0 COMMENT '点赞数',
    `comment_count` INT DEFAULT 0 COMMENT '评论数',
    `collect_count` INT DEFAULT 0 COMMENT '收藏数',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`note_id`),
    KEY `idx_author_id` (`author_id`),
    KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记表';

-- ========================================
-- 5. 评论表
-- ========================================
CREATE TABLE IF NOT EXISTS `comment` (
    `comment_id` INT NOT NULL AUTO_INCREMENT COMMENT '评论ID',
    `note_id` INT NOT NULL COMMENT '笔记ID',
    `author_id` BIGINT NOT NULL COMMENT '作者ID',
    `parent_id` INT DEFAULT NULL COMMENT '父评论ID',
    `content` TEXT NOT NULL COMMENT '评论内容',
    `like_count` INT DEFAULT 0 COMMENT '点赞数',
    `reply_count` INT DEFAULT 0 COMMENT '回复数',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`comment_id`),
    KEY `idx_note_id` (`note_id`),
    KEY `idx_author_id` (`author_id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- ========================================
-- 6. 评论点赞表
-- ========================================
CREATE TABLE IF NOT EXISTS `comment_like` (
    `comment_like_id` INT NOT NULL AUTO_INCREMENT COMMENT '评论点赞ID',
    `comment_id` INT NOT NULL COMMENT '评论ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`comment_like_id`),
    UNIQUE KEY `uk_comment_user` (`comment_id`, `user_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论点赞表';

-- ========================================
-- 7. 笔记点赞表
-- ========================================
CREATE TABLE IF NOT EXISTS `note_like` (
    `note_id` INT NOT NULL COMMENT '笔记ID',
    `user_id` BIGINT NOT NULL COMMENT '点赞用户ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`note_id`, `user_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记点赞表';

-- ========================================
-- 8. 笔记收藏表
-- ========================================
CREATE TABLE IF NOT EXISTS `note_collect` (
    `collect_id` INT NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    `note_id` INT NOT NULL COMMENT '笔记ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`collect_id`),
    UNIQUE KEY `uk_note_user` (`note_id`, `user_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记收藏表';

-- ========================================
-- 9. 收藏夹表
-- ========================================
CREATE TABLE IF NOT EXISTS `collection` (
    `collection_id` INT NOT NULL AUTO_INCREMENT COMMENT '收藏夹ID',
    `name` VARCHAR(100) NOT NULL COMMENT '收藏夹名称',
    `description` VARCHAR(500) DEFAULT NULL COMMENT '收藏夹描述',
    `creator_id` BIGINT NOT NULL COMMENT '收藏夹创建者ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`collection_id`),
    KEY `idx_creator_id` (`creator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏夹表';

-- ========================================
-- 10. 收藏夹-笔记关联表
-- ========================================
CREATE TABLE IF NOT EXISTS `collection_note` (
    `collection_id` INT NOT NULL COMMENT '收藏夹ID',
    `note_id` INT NOT NULL COMMENT '笔记ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`collection_id`, `note_id`),
    KEY `idx_note_id` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏夹-笔记关联表';

-- ========================================
-- 11. 题单表
-- ========================================
CREATE TABLE IF NOT EXISTS `question_list` (
    `question_list_id` INT NOT NULL AUTO_INCREMENT COMMENT '题单ID',
    `name` VARCHAR(100) NOT NULL COMMENT '题单名称',
    `type` TINYINT DEFAULT 1 COMMENT '题单类型',
    `description` VARCHAR(500) DEFAULT NULL COMMENT '题单描述',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`question_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题单表';

-- ========================================
-- 12. 题单-题目关联表
-- ========================================
CREATE TABLE IF NOT EXISTS `question_list_item` (
    `question_list_id` INT NOT NULL COMMENT '题单ID',
    `question_id` INT NOT NULL COMMENT '题目ID',
    `rank` INT DEFAULT 1 COMMENT '题单内题目的顺序',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`question_list_id`, `question_id`),
    KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题单-题目关联表';

-- ========================================
-- 13. 消息表
-- ========================================
CREATE TABLE IF NOT EXISTS `message` (
    `message_id` INT NOT NULL AUTO_INCREMENT COMMENT '消息ID',
    `receiver_id` BIGINT NOT NULL COMMENT '接收者ID',
    `sender_id` BIGINT DEFAULT NULL COMMENT '发送者ID',
    `type` TINYINT NOT NULL COMMENT '消息类型',
    `target_id` INT DEFAULT NULL COMMENT '目标ID',
    `target_type` TINYINT DEFAULT NULL COMMENT '目标类型',
    `content` VARCHAR(1000) DEFAULT NULL COMMENT '消息内容',
    `is_read` TINYINT DEFAULT 0 COMMENT '是否已读：0=未读，1=已读',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`message_id`),
    KEY `idx_receiver_id` (`receiver_id`),
    KEY `idx_sender_id` (`sender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';

-- ========================================
-- 14. 统计表
-- ========================================
CREATE TABLE IF NOT EXISTS `statistic` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `login_count` INT DEFAULT 0 COMMENT '当天登录次数',
    `register_count` INT DEFAULT 0 COMMENT '当天注册人数',
    `total_register_count` INT DEFAULT 0 COMMENT '累计注册总人数',
    `note_count` INT DEFAULT 0 COMMENT '当天笔记数量',
    `submit_note_count` INT DEFAULT 0 COMMENT '当天提交的笔记数量',
    `total_note_count` INT DEFAULT 0 COMMENT '累计笔记总数量',
    `date` DATE NOT NULL COMMENT '统计日期',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='统计表';

-- ========================================
-- 初始化数据
-- ========================================

-- 插入默认管理员账号（密码需要加密，这里使用 BCrypt 加密的 "admin123"）
-- INSERT INTO `user` (`account`, `username`, `password`, `email`, `is_admin`) 
-- VALUES ('admin', '管理员', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt/vKAO', 'admin@example.com', 1);

-- 插入示例分类
INSERT INTO `category` (`name`, `parent_category_id`) VALUES 
('前端', 0),
('后端', 0),
('数据库', 0),
('算法', 0),
('计算机基础', 0);

-- 插入示例题单
INSERT INTO `question_list` (`name`, `type`, `description`) VALUES 
('热门面试题', 1, '最受欢迎的面试题集合'),
('每日一题', 2, '每日精选面试题');

SELECT '数据库初始化完成！' AS message;
