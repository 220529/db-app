-- 数据库初始化脚本（首次启动时自动执行）

-- 创建 ERP 核心数据库
CREATE DATABASE IF NOT EXISTS `erp_core` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 如果需要其他数据库，可以直接添加：
-- CREATE DATABASE IF NOT EXISTS `数据库名` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

