FROM php:8.1-apache

# Cài đặt các thư viện cần thiết
RUN apt-get update && apt-get install -y libssl-dev && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb

# Sao chép code vào container
COPY . /var/www/html/

# Khởi động Apache
CMD ["apache2-foreground"]
