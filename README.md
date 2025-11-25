# 数据库服务

统一管理 MySQL、Redis 等基础服务,支持本地开发和生产部署。

---

## 🚀 本地开发

```bash
# 启动
docker-compose up -d

# 停止
docker-compose down
```

### 服务信息

| 服务 | 地址 | 账号密码 |
|------|------|---------|
| MySQL | localhost:3306 | root / root |
| Redis | localhost:6379 | redis123 |
| phpMyAdmin | http://localhost:8888 | root / root |

### 自动创建的数据库

- `erp_core` - ERP 核心数据库
- `erp_test` - 测试数据库
- `erp_user` 用户 (密码: erp_password_123)

---

## 🌐 生产部署

```bash
# 启动
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d

# 停止
docker-compose -f docker-compose.prod.yml down
```

**配置**: 编辑 `.env.prod` 修改密码

---

## 📝 常用命令

```bash
# 查看状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 备份数据库
docker exec dev-mysql mysqldump -uroot -proot erp_core > backup.sql

# 恢复数据库
docker exec -i dev-mysql mysql -uroot -proot erp_core < backup.sql
```

---

## 🔧 添加新数据库

编辑 `mysql/init/01-create-databases.sql`:

```sql
CREATE DATABASE IF NOT EXISTS `your_db` 
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'your_user'@'%' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON `your_db`.* TO 'your_user'@'%';
FLUSH PRIVILEGES;
```

重建容器: `docker-compose down -v && docker-compose up -d`
