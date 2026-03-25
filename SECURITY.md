# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in this project, please email security@[yourorg].com with:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if available)

Please do not open a public GitHub issue for security vulnerabilities.

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |

## Security Best Practices

### Docker Image Security
- Uses official `wordpress:6.4-php8.2-apache` base image with regular updates
- Multi-stage build minimizes final image size and attack surface
- All dependencies installed with `--no-install-recommends` to reduce bloat
- File permissions properly configured (www-data ownership)
- Health checks enabled on all services

### Database Security
- MySQL 8.0 with strong password requirements
- Credentials should be rotated in production
- Use `.env` file for secrets (not committed to repo)
- Database volumes are mounted and persistent

### Dependency Management
GitHub Dependabot monitors:
- Base image updates (wordpress, mysql, phpmyadmin)
- PHP security patches
- Apache security updates

Enable Dependabot in your repository settings to receive:
- Dependency vulnerability alerts
- Automated pull requests for security patches
- Automatic merging of minor updates (when configured)

### Environment Variables
Never commit sensitive data. Use Docker secrets or environment files:

```bash
# .env (add to .gitignore)
WORDPRESS_DB_PASSWORD=secure_password_here
MYSQL_ROOT_PASSWORD=secure_root_password_here
```

Load with: `docker compose --env-file .env up`

### Network Security
- Services communicate over isolated Docker network (oceanwp-network)
- Only WordPress (port 80) and phpMyAdmin (port 8081) exposed to host
- MySQL port 3306 only accessible from other containers

### Volume Security
- Named volumes with proper Docker permissions
- Data persisted securely between restarts
- Consider using encrypted volumes in production

## Updating Images

```bash
# Pull latest security patches
docker compose pull

# Rebuild with latest base image
docker compose up -d --build

# Remove unused images
docker image prune -a
```

## Additional Resources
- [WordPress Security](https://wordpress.org/support/article/hardening-wordpress/)
- [Docker Security Best Practices](https://docs.docker.com/engine/security/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
