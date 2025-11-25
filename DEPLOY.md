# GitHub Actions 部署指南

## 📋 需要配置的 GitHub Secrets

在 GitHub 仓库设置中添加以下 Secrets:

### 服务器连接信息

| Secret 名称 | 说明 | 示例值 |
|------------|------|--------|
| `SSH_HOST` | 服务器 IP 地址 | `47.xxx.xxx.xxx` |
| `SSH_USERNAME` | SSH 用户名 | `root` |
| `SSH_PASSWORD` | SSH 密码 | `your_password` |

### 数据库密码

| Secret 名称 | 说明 | 示例值 |
|------------|------|--------|
| `MYSQL_ROOT_PASSWORD` | MySQL root 密码 | `Erp2024MySQL@Prod#xxx` |
| `REDIS_PASSWORD` | Redis 密码 | `Erp2024Redis@Prod#xxx` |

---

## 🚀 部署流程

### 1. 配置 GitHub Secrets

1. 进入 GitHub 仓库
2. Settings → Secrets and variables → Actions
3. 点击 "New repository secret"
4. 添加上述 5 个 Secrets

### 2. 准备服务器

```bash
# SSH 到服务器
ssh root@your-server-ip

# 安装 Docker
curl -fsSL https://get.docker.com | bash
systemctl start docker
systemctl enable docker

# 创建部署目录
mkdir -p /var/www/db-app
```

### 3. 触发部署

**方式 A: 推送代码自动部署**
```bash
git add .
git commit -m "update db config"
git push origin main
```

**方式 B: 手动触发**
1. 进入 GitHub 仓库
2. Actions → Deploy DB Services
3. 点击 "Run workflow"

### 4. 查看部署日志

在 GitHub Actions 页面查看部署进度和日志

---

## ✅ 验证部署

SSH 到服务器验证:

```bash
cd /var/www/db-app

# 查看容器状态
docker-compose -f docker-compose.prod.yml ps

# 测试 MySQL
docker exec erp-mysql mysql -uroot -p密码 -e "SHOW DATABASES;"

# 测试 Redis
docker exec erp-redis redis-cli -a 密码 ping
```

---

## 🔄 更新部署

修改配置后,推送代码即可自动部署:

```bash
# 修改配置
vim docker-compose.prod.yml

# 提交并推送
git add .
git commit -m "update config"
git push

# GitHub Actions 会自动部署
```

---

## 🆘 常见问题

### Q: 部署失败怎么办?

查看 GitHub Actions 日志,常见原因:
- SSH 连接失败: 检查 Secrets 配置
- 端口被占用: 修改端口配置
- 权限问题: 确保 SSH 用户有 Docker 权限

### Q: 如何回滚?

```bash
# SSH 到服务器
cd /var/www/db-app

# 停止服务
docker-compose -f docker-compose.prod.yml down

# 恢复旧配置
git checkout HEAD~1

# 重新启动
docker-compose -f docker-compose.prod.yml up -d
```

---

## 💡 优势

相比构建镜像的方式:
- ✅ 不需要阿里云镜像仓库
- ✅ 不需要构建镜像 (使用官方镜像)
- ✅ 部署速度快 (只上传配置文件)
- ✅ 配置简单
- ✅ 成本低 (无镜像存储费用)
