-- ========================================
-- KamaNotes 扩展测试数据脚本
-- 为所有用户添加更多测试数据
-- ========================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

USE kamanote_tech;

-- 获取现有用户ID
SELECT @yangfeng_id := user_id FROM `user` WHERE account = 'yangfeng';
SELECT @zhangsan_id := user_id FROM `user` WHERE account = 'zhangsan';
SELECT @lisi_id := user_id FROM `user` WHERE account = 'lisi';
SELECT @wangwu_id := user_id FROM `user` WHERE account = 'wangwu';

-- ========================================
-- 1. 添加更多问题 (20个新问题)
-- ========================================
INSERT INTO `question` (`category_id`, `title`, `difficulty`, `exam_point`, `view_count`) VALUES
-- 前端问题
(1, 'Vue3 Composition API vs Options API的区别', 2, 'Vue3、Composition API、响应式原理', 289),
(1, 'Webpack和Vite的打包原理对比', 3, '构建工具、模块化、性能优化', 412),
(1, 'CSS Grid和Flexbox的使用场景', 1, 'CSS布局、响应式设计', 567),
(1, 'TypeScript泛型的高级用法', 3, '泛型、类型系统、类型推导', 334),
(1, '前端性能优化的最佳实践', 2, '性能优化、首屏加载、懒加载', 678),

-- 后端问题
(2, 'Redis缓存穿透、击穿、雪崩的解决方案', 3, 'Redis、缓存策略、高并发', 523),
(2, 'Spring AOP的实现原理', 3, 'AOP、动态代理、切面编程', 445),
(2, 'RESTful API设计规范', 2, 'API设计、HTTP方法、状态码', 389),
(2, 'JWT和Session的区别与选择', 2, '身份认证、Token、会话管理', 512),
(2, 'MyBatis一级缓存和二级缓存', 2, 'MyBatis、缓存机制、ORM', 367),

-- 数据库问题
(3, 'MySQL主从复制原理', 3, '主从复制、binlog、数据同步', 456),
(3, 'SQL注入攻击与防御', 2, 'SQL注入、安全防护、参数化查询', 589),
(3, '数据库分库分表策略', 3, '分库分表、数据分片、高可用', 423),

-- 算法问题
(4, '动态规划的解题思路', 3, '动态规划、状态转移、最优子结构', 712),
(4, '二分查找的变体问题', 2, '二分查找、边界处理、时间复杂度', 634),
(4, '链表反转的多种实现', 2, '链表、指针操作、递归', 556),
(4, '字符串匹配算法KMP', 3, 'KMP算法、模式匹配、next数组', 489),

-- 计算机基础问题
(5, 'HTTP和HTTPS的区别', 1, 'HTTP协议、SSL/TLS、加密传输', 823),
(5, '进程和线程的区别', 2, '操作系统、并发、资源管理', 745),
(5, '死锁的四个必要条件', 2, '死锁、资源分配、并发控制', 567);

-- ========================================
-- 2. 张三的笔记 (5篇)
-- ========================================
INSERT INTO `note` (`author_id`, `question_id`, `content`, `like_count`, `comment_count`, `collect_count`) VALUES
(@zhangsan_id, 9, '# Vue3 Composition API详解

## 为什么要用Composition API？
1. 更好的逻辑复用
2. 更灵活的代码组织
3. 更好的类型推导

## 基本用法
```javascript
import { ref, computed, watch } from "vue"

export default {
  setup() {
    const count = ref(0)
    const double = computed(() => count.value * 2)

    watch(count, (newVal) => {
      console.log("count changed:", newVal)
    })

    return { count, double }
  }
}
```

## 与Options API对比
- Composition API更适合大型项目
- Options API更适合简单组件
- 两者可以混用', 18, 4, 10),

(@zhangsan_id, 11, '# CSS Grid布局实战

## Grid基础
```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 20px;
}
```

## 常用属性
- grid-template-columns: 定义列
- grid-template-rows: 定义行
- grid-gap: 设置间距
- grid-area: 定义区域

## 实战案例
响应式卡片布局、圣杯布局、瀑布流布局', 25, 6, 15),

(@zhangsan_id, 14, '# Redis缓存问题解决方案

## 缓存穿透
问题：查询不存在的数据
解决：布隆过滤器、缓存空对象

## 缓存击穿
问题：热点key过期
解决：互斥锁、永不过期

## 缓存雪崩
问题：大量key同时过期
解决：过期时间加随机值、多级缓存', 35, 8, 22),

(@zhangsan_id, 18, '# HTTP vs HTTPS

## 主要区别
1. HTTPS使用SSL/TLS加密
2. HTTPS需要CA证书
3. HTTPS端口443，HTTP端口80

## HTTPS工作流程
1. 客户端发起请求
2. 服务器返回证书
3. 客户端验证证书
4. 协商加密算法
5. 建立加密连接

## 性能影响
HTTPS会增加握手时间，但现代优化已大幅降低影响', 28, 5, 18),

(@zhangsan_id, 19, '# 进程与线程

## 核心区别
- 进程是资源分配的基本单位
- 线程是CPU调度的基本单位
- 进程间相互独立，线程共享进程资源

## 通信方式
进程：管道、消息队列、共享内存
线程：共享变量、互斥锁、条件变量

## 使用场景
多进程：隔离性要求高
多线程：需要频繁通信', 32, 7, 20),

-- ========================================
-- 3. 李四的笔记 (5篇)
-- ========================================
(@lisi_id, 10, '# Webpack vs Vite

## 构建速度对比
Vite利用ESM实现极速冷启动
Webpack需要打包整个应用

## 开发体验
Vite：秒级HMR
Webpack：较慢的热更新

## 生产构建
Vite使用Rollup
Webpack功能更全面

## 选择建议
新项目推荐Vite，老项目可继续用Webpack', 22, 5, 14),

(@lisi_id, 13, '# 前端性能优化

## 加载优化
1. 代码分割
2. 懒加载
3. 预加载
4. CDN加速

## 渲染优化
1. 虚拟滚动
2. 防抖节流
3. 避免重排重绘

## 资源优化
1. 图片压缩
2. 字体优化
3. Tree Shaking

## 监控工具
Lighthouse、WebPageTest', 30, 6, 19),

(@lisi_id, 16, '# RESTful API设计

## 核心原则
1. 使用HTTP方法表达操作
2. 使用名词表示资源
3. 使用状态码表示结果

## 最佳实践
```
GET /users - 获取用户列表
GET /users/123 - 获取单个用户
POST /users - 创建用户
PUT /users/123 - 更新用户
DELETE /users/123 - 删除用户
```

## 版本控制
URL版本：/api/v1/users
Header版本：Accept: application/vnd.api+json;version=1', 26, 4, 16),

(@lisi_id, 21, '# 动态规划解题

## 解题步骤
1. 定义状态
2. 找状态转移方程
3. 确定初始状态
4. 确定计算顺序

## 经典问题
- 背包问题
- 最长公共子序列
- 最长递增子序列
- 股票买卖

## 优化技巧
- 滚动数组优化空间
- 记忆化搜索', 38, 9, 24),

(@lisi_id, 23, '# 链表反转

## 迭代法
```java
public ListNode reverse(ListNode head) {
    ListNode prev = null;
    ListNode curr = head;

    while (curr != null) {
        ListNode next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }

    return prev;
}
```

## 递归法
```java
public ListNode reverse(ListNode head) {
    if (head == null || head.next == null) {
        return head;
    }

    ListNode newHead = reverse(head.next);
    head.next.next = head;
    head.next = null;

    return newHead;
}
```', 34, 7, 21),

-- ========================================
-- 4. 王五的笔记 (5篇)
-- ========================================
(@wangwu_id, 12, '# TypeScript泛型

## 基础用法
```typescript
function identity<T>(arg: T): T {
    return arg;
}
```

## 泛型约束
```typescript
interface Lengthwise {
    length: number;
}

function log<T extends Lengthwise>(arg: T): T {
    console.log(arg.length);
    return arg;
}
```

## 实战应用
- 通用API请求函数
- 类型安全的状态管理
- 工具类型封装', 27, 6, 17),

(@wangwu_id, 15, '# Spring AOP原理

## 核心概念
- 切面(Aspect)
- 连接点(JoinPoint)
- 切点(Pointcut)
- 通知(Advice)

## 实现方式
1. JDK动态代理：基于接口
2. CGLIB代理：基于继承

## 应用场景
- 日志记录
- 事务管理
- 权限控制
- 性能监控

## 示例代码
```java
@Aspect
@Component
public class LogAspect {
    @Before("execution(* com.example..*(..))")
    public void before(JoinPoint jp) {
        System.out.println("方法执行前");
    }
}
```', 31, 7, 19),

(@wangwu_id, 17, '# JWT vs Session

## JWT优势
- 无状态，易扩展
- 跨域友好
- 移动端友好

## Session优势
- 服务端可控
- 更安全
- 占用带宽小

## 选择建议
- 单体应用：Session
- 微服务：JWT
- 混合方案：Refresh Token

## 安全注意
- JWT存储位置
- Token过期策略
- 防止XSS和CSRF', 29, 6, 18),

(@wangwu_id, 20, '# MySQL主从复制

## 复制原理
1. 主库写binlog
2. 从库IO线程读取binlog
3. 从库SQL线程执行binlog

## 复制模式
- 异步复制
- 半同步复制
- 全同步复制

## 应用场景
- 读写分离
- 数据备份
- 高可用

## 常见问题
- 主从延迟
- 数据不一致
- 主库宕机处理', 33, 8, 20),

(@wangwu_id, 22, '# 二分查找变体

## 标准二分
```java
int binarySearch(int[] arr, int target) {
    int left = 0, right = arr.length - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) return mid;
        else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }

    return -1;
}
```

## 查找左边界
寻找第一个等于target的位置

## 查找右边界
寻找最后一个等于target的位置

## 旋转数组查找
需要判断哪一半是有序的', 36, 8, 23);

-- ========================================
-- 5. 添加更多评论 (40条新评论)
-- ========================================
INSERT INTO `comment` (`note_id`, `author_id`, `content`, `like_count`) VALUES
-- yangfeng的笔记评论
(1, @zhangsan_id, '闭包讲得很透彻，终于理解了！', 8),
(1, @lisi_id, '示例代码很实用，已收藏', 5),
(1, @wangwu_id, '能再讲讲闭包的内存泄漏问题吗？', 3),
(2, @zhangsan_id, 'useEffect的依赖数组确实是个坑', 6),
(2, @wangwu_id, '自定义Hook部分写得很好', 4),
(3, @lisi_id, '索引优化这块太实用了', 10),
(3, @wangwu_id, '覆盖索引的概念第一次听说', 7),
(4, @zhangsan_id, '快排代码写得很清晰', 9),
(4, @lisi_id, '三数取中法能详细说说吗', 5),
(5, @wangwu_id, '层序遍历用队列确实最直观', 6),

-- 张三的笔记评论
(6, @yangfeng_id, 'Composition API确实比Options API灵活', 7),
(6, @lisi_id, '代码示例很清楚', 4),
(6, @wangwu_id, 'setup函数的返回值有什么讲究吗？', 3),
(7, @yangfeng_id, 'Grid布局真的很强大', 8),
(7, @lisi_id, '圣杯布局的实现能分享一下吗', 5),
(8, @yangfeng_id, '缓存三大问题总结得很好', 12),
(8, @lisi_id, '布隆过滤器的实现复杂吗？', 6),
(8, @wangwu_id, '生产环境用过，确实有效', 9),
(9, @yangfeng_id, 'HTTPS的性能影响现在确实很小了', 7),
(9, @lisi_id, 'CA证书的申请流程能讲讲吗', 4),
(10, @yangfeng_id, '进程线程的区别讲得很清楚', 8),
(10, @wangwu_id, '协程和线程的区别呢？', 5),

-- 李四的笔记评论
(11, @yangfeng_id, 'Vite确实比Webpack快很多', 9),
(11, @zhangsan_id, '老项目迁移到Vite麻烦吗？', 6),
(11, @wangwu_id, 'Rollup的配置比Webpack简单', 4),
(12, @yangfeng_id, '性能优化总结得很全面', 11),
(12, @zhangsan_id, '虚拟滚动的实现原理能讲讲吗', 7),
(12, @wangwu_id, 'Lighthouse工具很好用', 5),
(13, @yangfeng_id, 'RESTful设计规范很重要', 8),
(13, @zhangsan_id, 'GraphQL和REST怎么选择？', 6),
(14, @yangfeng_id, '动态规划确实需要多练', 10),
(14, @zhangsan_id, '状态转移方程最难想', 7),
(14, @wangwu_id, '背包问题的变体太多了', 5),
(15, @yangfeng_id, '链表反转的递归写法很优雅', 9),
(15, @zhangsan_id, '迭代法更好理解', 6),

-- 王五的笔记评论
(16, @yangfeng_id, 'TypeScript泛型很强大', 8),
(16, @zhangsan_id, '泛型约束的用法学到了', 5),
(16, @lisi_id, '工具类型有哪些推荐的？', 4),
(17, @yangfeng_id, 'AOP在Spring中应用很广', 9),
(17, @zhangsan_id, 'CGLIB和JDK代理的性能差异大吗', 6),
(17, @lisi_id, '事务管理就是用AOP实现的', 7),
(18, @yangfeng_id, 'JWT的无状态特性很适合微服务', 10),
(18, @zhangsan_id, 'Refresh Token怎么设计？', 7),
(18, @lisi_id, 'Session在分布式下确实麻烦', 5),
(19, @yangfeng_id, '主从复制原理讲得很清楚', 11),
(19, @zhangsan_id, '主从延迟怎么解决？', 8),
(19, @lisi_id, '半同步复制性能如何', 6),
(20, @yangfeng_id, '二分查找的边界处理确实容易错', 9),
(20, @zhangsan_id, '左闭右开的写法更统一', 7),
(20, @lisi_id, '旋转数组的二分很经典', 5);

-- ========================================
-- 6. 添加更多点赞 (50条)
-- ========================================
INSERT IGNORE INTO `note_like` (`note_id`, `user_id`) VALUES
-- yangfeng点赞
(6, @yangfeng_id), (7, @yangfeng_id), (8, @yangfeng_id), (9, @yangfeng_id), (10, @yangfeng_id),
(11, @yangfeng_id), (12, @yangfeng_id), (13, @yangfeng_id), (14, @yangfeng_id), (15, @yangfeng_id),
(16, @yangfeng_id), (17, @yangfeng_id), (18, @yangfeng_id), (19, @yangfeng_id), (20, @yangfeng_id),

-- 张三点赞
(2, @zhangsan_id), (3, @zhangsan_id), (4, @zhangsan_id), (5, @zhangsan_id),
(11, @zhangsan_id), (12, @zhangsan_id), (13, @zhangsan_id), (14, @zhangsan_id), (15, @zhangsan_id),
(16, @zhangsan_id), (17, @zhangsan_id), (18, @zhangsan_id), (19, @zhangsan_id), (20, @zhangsan_id),

-- 李四点赞
(1, @lisi_id), (2, @lisi_id), (4, @lisi_id), (5, @lisi_id),
(6, @lisi_id), (7, @lisi_id), (8, @lisi_id), (9, @lisi_id), (10, @lisi_id),
(16, @lisi_id), (17, @lisi_id), (18, @lisi_id), (19, @lisi_id), (20, @lisi_id),

-- 王五点赞
(1, @wangwu_id), (2, @wangwu_id), (3, @wangwu_id), (5, @wangwu_id),
(6, @wangwu_id), (7, @wangwu_id), (11, @wangwu_id), (12, @wangwu_id), (13, @wangwu_id), (14, @wangwu_id);

-- ========================================
-- 7. 添加更多收藏 (30条)
-- ========================================
INSERT IGNORE INTO `note_collect` (`note_id`, `user_id`) VALUES
-- yangfeng收藏
(6, @yangfeng_id), (7, @yangfeng_id), (8, @yangfeng_id), (11, @yangfeng_id), (12, @yangfeng_id),
(14, @yangfeng_id), (17, @yangfeng_id), (19, @yangfeng_id),

-- 张三收藏
(3, @zhangsan_id), (4, @zhangsan_id), (5, @zhangsan_id), (12, @zhangsan_id), (13, @zhangsan_id),
(14, @zhangsan_id), (15, @zhangsan_id), (18, @zhangsan_id),

-- 李四收藏
(1, @lisi_id), (2, @lisi_id), (6, @lisi_id), (8, @lisi_id), (9, @lisi_id),
(16, @lisi_id), (17, @lisi_id), (19, @lisi_id),

-- 王五收藏
(2, @wangwu_id), (4, @wangwu_id), (7, @wangwu_id), (10, @wangwu_id), (13, @wangwu_id),
(15, @wangwu_id), (18, @wangwu_id), (20, @wangwu_id);

-- ========================================
-- 8. 添加评论点赞 (30条)
-- ========================================
INSERT IGNORE INTO `comment_like` (`comment_id`, `user_id`) VALUES
(11, @yangfeng_id), (12, @yangfeng_id), (13, @yangfeng_id), (14, @yangfeng_id), (15, @yangfeng_id),
(16, @yangfeng_id), (17, @yangfeng_id), (18, @yangfeng_id), (19, @yangfeng_id), (20, @yangfeng_id),
(11, @zhangsan_id), (12, @zhangsan_id), (21, @zhangsan_id), (22, @zhangsan_id), (23, @zhangsan_id),
(13, @lisi_id), (14, @lisi_id), (24, @lisi_id), (25, @lisi_id), (26, @lisi_id),
(15, @wangwu_id), (16, @wangwu_id), (27, @wangwu_id), (28, @wangwu_id), (29, @wangwu_id);

-- ========================================
-- 9. 更新收藏夹并添加笔记
-- ========================================
INSERT INTO `collection_note` (`collection_id`, `note_id`) VALUES
(1, 1), (1, 2), (1, 6), (1, 7), (1, 11), (1, 12),
(2, 4), (2, 5), (2, 14), (2, 15), (2, 20),
(3, 3), (3, 8), (3, 9), (3, 10), (3, 17), (3, 18), (3, 19);

-- ========================================
-- 10. 添加题单项目
-- ========================================
INSERT INTO `question_list_item` (`question_list_id`, `question_id`, `rank`) VALUES
(1, 1, 1), (1, 2, 2), (1, 4, 3), (1, 8, 4), (1, 14, 5),
(1, 15, 6), (1, 17, 7), (1, 18, 8), (1, 19, 9), (1, 20, 10),
(2, 6, 1), (2, 7, 2), (2, 21, 3), (2, 22, 4), (2, 23, 5);

-- ========================================
-- 11. 添加消息数据
-- ========================================
INSERT INTO `message` (`receiver_id`, `sender_id`, `type`, `target_id`, `target_type`, `content`, `is_read`) VALUES
-- 点赞通知
(@yangfeng_id, @zhangsan_id, 1, 1, 1, '张三点赞了你的笔记', 1),
(@yangfeng_id, @lisi_id, 1, 2, 1, '李四点赞了你的笔记', 1),
(@yangfeng_id, @wangwu_id, 1, 3, 1, '王五点赞了你的笔记', 0),
(@zhangsan_id, @yangfeng_id, 1, 6, 1, 'yangfeng点赞了你的笔记', 1),
(@lisi_id, @yangfeng_id, 1, 11, 1, 'yangfeng点赞了你的笔记', 0),

-- 评论通知
(@yangfeng_id, @zhangsan_id, 2, 11, 2, '张三评论了你的笔记', 1),
(@yangfeng_id, @lisi_id, 2, 12, 2, '李四评论了你的笔记', 0),
(@zhangsan_id, @yangfeng_id, 2, 21, 2, 'yangfeng评论了你的笔记', 1),
(@lisi_id, @yangfeng_id, 2, 31, 2, 'yangfeng评论了你的笔记', 0),

-- 收藏通知
(@yangfeng_id, @zhangsan_id, 3, 1, 1, '张三收藏了你的笔记', 1),
(@yangfeng_id, @lisi_id, 3, 2, 1, '李四收藏了你的笔记', 1),
(@zhangsan_id, @yangfeng_id, 3, 6, 1, 'yangfeng收藏了你的笔记', 0),

-- 系统通知
(@yangfeng_id, NULL, 4, NULL, NULL, '欢迎使用KamaNotes笔记系统', 1),
(@zhangsan_id, NULL, 4, NULL, NULL, '欢迎使用KamaNotes笔记系统', 1),
(@lisi_id, NULL, 4, NULL, NULL, '欢迎使用KamaNotes笔记系统', 1),
(@wangwu_id, NULL, 4, NULL, NULL, '欢迎使用KamaNotes笔记系统', 1);

-- ========================================
-- 12. 添加统计数据
-- ========================================
INSERT INTO `statistic` (`login_count`, `register_count`, `total_register_count`, `note_count`, `submit_note_count`, `total_note_count`, `date`) VALUES
(45, 3, 4, 5, 5, 5, '2026-01-15'),
(52, 0, 4, 8, 3, 8, '2026-01-16'),
(68, 0, 4, 12, 4, 12, '2026-01-17'),
(73, 0, 4, 20, 8, 20, '2026-01-18');

SELECT '扩展测试数据插入完成！' AS message;
SELECT '数据统计：' AS info;
SELECT COUNT(*) AS '总问题数' FROM question;
SELECT COUNT(*) AS '总笔记数' FROM note;
SELECT COUNT(*) AS '总评论数' FROM comment;
SELECT COUNT(*) AS '总点赞数' FROM note_like;
SELECT COUNT(*) AS '总收藏数' FROM note_collect;
