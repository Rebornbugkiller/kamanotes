-- ========================================
-- KamaNotes 测试数据脚本
-- 为用户 yangfeng 添加测试数据
-- ========================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

USE kamanote_tech;

-- ========================================
-- 1. 获取或创建用户 yangfeng
-- ========================================
-- 检查用户是否存在，如果不存在则创建
INSERT IGNORE INTO `user` (`account`, `username`, `password`, `gender`, `email`, `school`, `signature`, `is_admin`)
VALUES ('yangfeng', '杨烽', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt/vKAO', 1, 'yangfeng@example.com', '清华大学', '热爱编程，热爱生活', 0);

-- 获取yangfeng的用户ID
SELECT @yangfeng_user_id := user_id FROM `user` WHERE account = 'yangfeng';

-- ========================================
-- 2. 插入测试问题
-- ========================================
INSERT INTO `question` (`category_id`, `title`, `difficulty`, `exam_point`, `view_count`) VALUES
(1, 'JavaScript闭包的原理和应用场景', 2, '闭包、作用域链、内存管理', 156),
(1, 'React Hooks的使用规则和最佳实践', 2, 'useState、useEffect、自定义Hook', 234),
(2, 'Spring Boot自动配置原理', 3, '自动配置、条件注解、starter机制', 189),
(2, 'MySQL索引优化策略', 3, 'B+树、索引失效、覆盖索引', 312),
(3, '数据库事务的ACID特性', 2, '原子性、一致性、隔离性、持久性', 278),
(4, '快速排序算法的实现和优化', 2, '分治算法、时间复杂度、空间复杂度', 445),
(4, '二叉树的层序遍历', 1, 'BFS、队列、树的遍历', 523),
(5, 'TCP三次握手和四次挥手', 2, 'TCP协议、网络通信、状态转换', 389);

-- ========================================
-- 3. 插入yangfeng的笔记
-- ========================================
INSERT INTO `note` (`author_id`, `question_id`, `content`, `like_count`, `comment_count`, `collect_count`) VALUES
(@yangfeng_user_id, 1, '# JavaScript闭包详解

## 什么是闭包？
闭包是指有权访问另一个函数作用域中变量的函数。

## 闭包的应用场景
1. **数据私有化**：通过闭包可以创建私有变量
2. **函数工厂**：返回定制化的函数
3. **回调函数**：保持对外部变量的引用

## 示例代码
```javascript
function createCounter() {
  let count = 0;
  return {
    increment: () => ++count,
    decrement: () => --count,
    getCount: () => count
  };
}

const counter = createCounter();
console.log(counter.increment()); // 1
console.log(counter.getCount()); // 1
```

## 注意事项
- 闭包会导致变量不会被垃圾回收，可能造成内存泄漏
- 在循环中创建闭包要特别注意变量的作用域', 15, 3, 8),

(@yangfeng_user_id, 2, '# React Hooks 最佳实践

## useState 使用技巧
1. 使用函数式更新避免闭包陷阱
2. 合理拆分state，避免过度集中

```javascript
// 推荐：函数式更新
setCount(prev => prev + 1);

// 不推荐：直接使用外部变量
setCount(count + 1);
```

## useEffect 注意事项
1. 正确设置依赖数组
2. 清理副作用（返回清理函数）
3. 避免在effect中直接修改state

```javascript
useEffect(() => {
  const timer = setInterval(() => {
    console.log("tick");
  }, 1000);

  // 清理函数
  return () => clearInterval(timer);
}, []);
```

## 自定义Hook
将复用逻辑抽取为自定义Hook，提高代码复用性。', 23, 5, 12),

(@yangfeng_user_id, 4, '# MySQL索引优化全攻略

## 索引类型
- **B+树索引**：最常用的索引类型
- **哈希索引**：等值查询快，不支持范围查询
- **全文索引**：用于文本搜索

## 索引失效场景
1. 使用函数或表达式操作索引列
2. 隐式类型转换
3. like查询以%开头
4. or条件中有非索引列
5. 联合索引不满足最左前缀原则

## 优化建议
```sql
-- 不推荐：索引失效
SELECT * FROM user WHERE YEAR(created_at) = 2024;

-- 推荐：使用索引
SELECT * FROM user WHERE created_at >= "2024-01-01" AND created_at < "2025-01-01";
```

## 覆盖索引
查询的列都在索引中，避免回表查询，性能最优。', 31, 7, 18),

(@yangfeng_user_id, 6, '# 快速排序详解

## 算法思想
选择一个基准元素，将数组分为两部分：
- 左边都小于基准
- 右边都大于基准
- 递归处理左右两部分

## 代码实现
```java
public void quickSort(int[] arr, int left, int right) {
    if (left >= right) return;

    int pivot = partition(arr, left, right);
    quickSort(arr, left, pivot - 1);
    quickSort(arr, pivot + 1, right);
}

private int partition(int[] arr, int left, int right) {
    int pivot = arr[right];
    int i = left - 1;

    for (int j = left; j < right; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(arr, i, j);
        }
    }
    swap(arr, i + 1, right);
    return i + 1;
}
```

## 时间复杂度
- 平均：O(n log n)
- 最坏：O(n²) - 数组已排序时
- 优化：三数取中法选择基准', 42, 9, 25),

(@yangfeng_user_id, 7, '# 二叉树层序遍历

## 解题思路
使用队列实现BFS（广度优先搜索）

## Java实现
```java
public List<List<Integer>> levelOrder(TreeNode root) {
    List<List<Integer>> result = new ArrayList<>();
    if (root == null) return result;

    Queue<TreeNode> queue = new LinkedList<>();
    queue.offer(root);

    while (!queue.isEmpty()) {
        int levelSize = queue.size();
        List<Integer> currentLevel = new ArrayList<>();

        for (int i = 0; i < levelSize; i++) {
            TreeNode node = queue.poll();
            currentLevel.add(node.val);

            if (node.left != null) queue.offer(node.left);
            if (node.right != null) queue.offer(node.right);
        }

        result.add(currentLevel);
    }

    return result;
}
```

## 关键点
- 使用队列的size记录当前层的节点数
- 每次处理完一层再处理下一层', 28, 4, 15);

-- ========================================
-- 4. 插入其他用户（用于评论和互动）
-- ========================================
INSERT IGNORE INTO `user` (`account`, `username`, `password`, `gender`, `email`) VALUES
('zhangsan', '张三', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt/vKAO', 1, 'zhangsan@example.com'),
('lisi', '李四', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt/vKAO', 2, 'lisi@example.com'),
('wangwu', '王五', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt/vKAO', 1, 'wangwu@example.com');

SELECT @zhangsan_id := user_id FROM `user` WHERE account = 'zhangsan';
SELECT @lisi_id := user_id FROM `user` WHERE account = 'lisi';
SELECT @wangwu_id := user_id FROM `user` WHERE account = 'wangwu';

-- ========================================
-- 5. 插入评论数据
-- ========================================
INSERT INTO `comment` (`note_id`, `author_id`, `content`, `like_count`) VALUES
(1, @zhangsan_id, '讲解得很清楚！闭包这个概念终于理解了', 5),
(1, @lisi_id, '示例代码很实用，感谢分享', 3),
(1, @wangwu_id, '请问闭包在实际项目中使用频率高吗？', 2),
(2, @zhangsan_id, 'useEffect的依赖数组确实容易出错，学到了', 8),
(2, @lisi_id, '自定义Hook的部分能再详细讲讲吗？', 4),
(3, @wangwu_id, '索引优化这块讲得太好了，收藏了！', 12),
(3, @zhangsan_id, '覆盖索引的概念第一次听说，涨知识了', 6),
(4, @lisi_id, '快排的代码实现很优雅', 7),
(4, @wangwu_id, '三数取中法是什么？能展开讲讲吗', 3),
(5, @zhangsan_id, '层序遍历用队列确实是最直观的方法', 5);

-- ========================================
-- 6. 插入点赞数据
-- ========================================
INSERT IGNORE INTO `note_like` (`note_id`, `user_id`) VALUES
(1, @zhangsan_id),
(1, @lisi_id),
(1, @wangwu_id),
(2, @zhangsan_id),
(2, @lisi_id),
(3, @zhangsan_id),
(3, @lisi_id),
(3, @wangwu_id),
(4, @zhangsan_id),
(5, @lisi_id);

-- yangfeng给其他笔记点赞
INSERT IGNORE INTO `note_like` (`note_id`, `user_id`) VALUES
(1, @yangfeng_user_id),
(2, @yangfeng_user_id);

-- ========================================
-- 7. 插入收藏数据
-- ========================================
INSERT IGNORE INTO `note_collect` (`note_id`, `user_id`) VALUES
(1, @zhangsan_id),
(2, @zhangsan_id),
(3, @lisi_id),
(3, @wangwu_id),
(4, @zhangsan_id),
(5, @lisi_id);

-- ========================================
-- 8. 创建yangfeng的收藏夹
-- ========================================
INSERT INTO `collection` (`name`, `description`, `creator_id`) VALUES
('前端精选', '收集优质的前端技术笔记', @yangfeng_user_id),
('算法题解', '常见算法题的解题思路', @yangfeng_user_id),
('面试必备', '面试高频考点整理', @yangfeng_user_id);

-- ========================================
-- 9. 插入评论点赞
-- ========================================
INSERT IGNORE INTO `comment_like` (`comment_id`, `user_id`) VALUES
(1, @yangfeng_user_id),
(2, @yangfeng_user_id),
(4, @yangfeng_user_id),
(6, @yangfeng_user_id);

SELECT '测试数据插入完成！' AS message;
SELECT CONCAT('用户yangfeng的ID: ', @yangfeng_user_id) AS user_info;
