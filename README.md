# 开发环境数据库

统一管理开发环境的 MySQL、Redis 等基础服务。

## 快速启动

```bash
# 启动所有服务
docker-compose up -d

# 查看状态
docker-compose ps

# 停止服务
docker-compose stop

# 停止并删除容器（数据保留）
docker-compose down

# 停止并删除容器和数据（危险操作！）
docker-compose down -v
```

## 服务列表

| 服务 | 端口 | 访问地址 | 账号密码 |
|------|------|----------|----------|
| MySQL | 3306 | localhost:3306 | root / root |
| Redis | 6379 | localhost:6379 | 无密码 |
| phpMyAdmin | 8888 | http://localhost:8888 | root / root |

## 数据持久化

数据存储在 Docker 数据卷中，即使删除容器数据也不会丢失：

```bash
# 查看数据卷
docker volume ls | grep db-app

# 完全重置（会删除所有数据！）
docker-compose down -v
docker-compose up -d
```

## 创建新数据库

### 方式1：phpMyAdmin（推荐）
1. 访问 http://localhost:8888
2. 登录（root / root）
3. 点击"新建" → 输入数据库名 → 创建

### 方式2：命令行
```bash
docker exec -it dev-mysql mysql -uroot -proot -e "CREATE DATABASE 数据库名"
```

### 方式3：修改初始化脚本
1. 编辑 `mysql/init/01-create-databases.sql`
2. 添加：`CREATE DATABASE IF NOT EXISTS 数据库名 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
3. 重建容器：`docker-compose down -v && docker-compose up -d`

## 连接配置

在你的项目 `.env` 文件中：

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=root123456
DB_DATABASE=erp_core
```

## 常见问题

### 端口被占用
如果 3306 端口被占用，修改 `docker-compose.yml`：
```yaml
ports:
  - "3307:3306"  # 改用 3307
```

### 忘记密码
密码在 `docker-compose.yml` 中：
```yaml
MYSQL_ROOT_PASSWORD: root
```

### 数据库连接失败
```bash
# 检查容器状态
docker-compose ps

# 查看日志
docker-compose logs mysql

# 重启服务
docker-compose restart mysql
```

## 备份与恢复

### 备份
```bash
# 备份单个数据库
docker exec dev-mysql mysqldump -uroot -proot erp_core > backup.sql

# 备份所有数据库
docker exec dev-mysql mysqldump -uroot -proot --all-databases > backup-all.sql
```

### 恢复
```bash
# 恢复数据库
docker exec -i dev-mysql mysql -uroot -proot erp_core < backup.sql
```

## 注意事项

1. **不要用于生产环境**：这是开发环境配置
2. **密码安全**：生产环境请使用强密码
3. **数据备份**：重要数据请定期备份
4. **端口冲突**：确保端口未被占用
