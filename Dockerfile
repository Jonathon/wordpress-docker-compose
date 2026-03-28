# Multi-stage build for WordPress with OceanWP Child Theme
FROM wordpress:6.4-php8.2-apache AS base

# Install build dependencies in one layer to reduce image size
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy theme files to WordPress themes directory
COPY --chown=www-data:www-data . /var/www/html/wp-content/themes/oceanwp-child-theme/

# Set proper permissions for theme directory
RUN chmod -R 755 /var/www/html/wp-content/themes/oceanwp-child-theme/

# Production stage - clean image
FROM wordpress:6.4-php8.2-apache

# Install runtime dependencies only (minimal production image)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libxml2 \
    curl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set proper file permissions before copying
RUN chmod -R 755 /var/www/html/wp-content && \
    chown -R www-data:www-data /var/www/html/wp-content

# Copy WordPress theme from base stage
COPY --from=base --chown=www-data:www-data /var/www/html/wp-content/themes/oceanwp-child-theme/ /var/www/html/wp-content/themes/oceanwp-child-theme/

# Set working directory
WORKDIR /var/www/html

# Configure Apache modules for security and performance
RUN a2enmod rewrite headers deflate

# Health check with curl (now available in runtime stage)
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

EXPOSE 80

CMD ["apache2-foreground"]
