# Sử dụng hình ảnh PHP chính thức với Apache
FROM php:8.1-apache

# Cài đặt các extension cần thiết
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Cài đặt MongoDB extension (nếu dùng MongoDB)
RUN apt-get update && apt-get install -y libssl-dev && pecl install mongodb && docker-php-ext-enable mongodb

# Sao chép toàn bộ code vào thư mục của Apache
COPY . /var/www/html/

# Cấp quyền truy cập cho Apache
RUN chown -R www-data:www-data /var/www/html

# Mở cổng 80 để ứng dụng có thể chạy
EXPOSE 80

# Khởi động Apache khi container chạy
CMD ["apache2-foreground"]
