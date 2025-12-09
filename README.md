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

| 服务  | 地址           | 账号密码    |
| ----- | -------------- | ----------- |
| MySQL | localhost:3306 | root / root |
| Redis | localhost:6379 | redis123    |

### 自动创建的数据库

- `erp_core` - ERP 核心数据库
- `erp_test` - 测试数据库
- `erp_user` 用户 (密码: erp_password_123)

---

## 🌐 生产部署

通过 Git Tag 触发自动部署：

```bash
git tag v1.0.0 && git push origin v1.0.0
```

或在 GitHub Actions 页面手动触发 "Run workflow"

### 手动部署

```bash
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

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
