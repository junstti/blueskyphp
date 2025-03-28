FROM php:8.1-apache

# Chạy lệnh với quyền root
USER root

# Cài đặt thư viện cần thiết
RUN apt-get update && apt-get install -y \
    libssl-dev libcurl4-openssl-dev pkg-config && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb

# Sao chép mã nguồn vào container
COPY . /var/www/html/

# Chạy Apache
CMD ["apache2-foreground"]
