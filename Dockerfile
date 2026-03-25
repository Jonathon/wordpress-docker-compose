# Multi-stage build for WordPress with OceanWP Child Theme
FROM wordpress:6.4-php8.2-apache AS base

# Install additional dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy theme files to WordPress themes directory
COPY --chown=www-data:www-data . /var/www/html/wp-content/themes/oceanwp-child-theme/

# Set proper permissions
RUN chmod -R 755 /var/www/html/wp-content/themes/oceanwp-child-theme/

# Production stage - clean image
FROM wordpress:6.4-php8.2-apache

# Install dependencies needed for production
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2 \
    && rm -rf /var/lib/apt/lists/*

# Copy WordPress theme from base stage
COPY --from=base --chown=www-data:www-data /var/www/html/wp-content/themes/oceanwp-child-theme/ /var/www/html/wp-content/themes/oceanwp-child-theme/

# Set working directory
WORKDIR /var/www/html

# Set proper file permissions
RUN chmod -R 755 /var/www/html/wp-content && \
    chown -R www-data:www-data /var/www/html/wp-content

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

EXPOSE 80

CMD ["apache2-foreground"]
