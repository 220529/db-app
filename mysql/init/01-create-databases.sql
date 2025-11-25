-- MySQL 初始化脚本 - 支持多项目共用数据库服务
-- 此脚本在容器首次启动时自动执行
-- 通过创建不同的数据库和用户来隔离不同项目

-- ==================== ERP 核心系统 ====================
-- 创建 ERP 核心数据库
CREATE DATABASE IF NOT EXISTS `erp_core` 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

-- 创建 ERP 专用用户 (生产环境请修改密码!)
CREATE USER IF NOT EXISTS 'erp_user'@'%' IDENTIFIED BY 'erp_password_123';
GRANT ALL PRIVILEGES ON `erp_core`.* TO 'erp_user'@'%';

-- 创建 ERP 测试数据库
CREATE DATABASE IF NOT EXISTS `erp_test` 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON `erp_test`.* TO 'erp_user'@'%';

-- ==================== 其他项目示例 ====================
-- 如果您有其他项目需要共用此数据库服务,可以在这里添加

-- 示例 1: CRM 系统
-- CREATE DATABASE IF NOT EXISTS `crm_system` 
--   CHARACTER SET utf8mb4 
--   COLLATE utf8mb4_unicode_ci;
-- CREATE USER IF NOT EXISTS 'crm_user'@'%' IDENTIFIED BY 'crm_password_123';
-- GRANT ALL PRIVILEGES ON `crm_system`.* TO 'crm_user'@'%';

-- 示例 2: 电商系统
-- CREATE DATABASE IF NOT EXISTS `ecommerce` 
--   CHARACTER SET utf8mb4 
--   COLLATE utf8mb4_unicode_ci;
-- CREATE USER IF NOT EXISTS 'ecommerce_user'@'%' IDENTIFIED BY 'ecommerce_password_123';
-- GRANT ALL PRIVILEGES ON `ecommerce`.* TO 'ecommerce_user'@'%';

-- 示例 3: 博客系统
-- CREATE DATABASE IF NOT EXISTS `blog` 
--   CHARACTER SET utf8mb4 
--   COLLATE utf8mb4_unicode_ci;
-- CREATE USER IF NOT EXISTS 'blog_user'@'%' IDENTIFIED BY 'blog_password_123';
-- GRANT ALL PRIVILEGES ON `blog`.* TO 'blog_user'@'%';

-- ==================== 刷新权限 ====================
FLUSH PRIVILEGES;

-- ==================== 使用说明 ====================
-- 1. 每个项目使用独立的数据库和用户,实现数据隔离
-- 2. 本地开发可以使用简单密码,生产环境必须修改为强密码
-- 3. 项目连接配置示例:
--    DB_HOST=localhost (或容器名 erp-mysql)
--    DB_PORT=3306
--    DB_USERNAME=erp_user
--    DB_PASSWORD=erp_password_123
--    DB_DATABASE=erp_core
-- 4. 如需添加新项目,复制上面的示例并修改数据库名和用户名即可
