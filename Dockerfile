# استخدم صورة PHP الرسمية
FROM php:8.2-apache

# فعّل بعض الإضافات المهمة للـ Laravel
RUN docker-php-ext-install pdo pdo_mysql

# انسخ كل ملفات المشروع داخل السيرفر
COPY . /var/www/html/

# غيّر صلاحيات المجلدات المهمة
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# فعّل rewrite module في Apache (عشان Laravel routing)
RUN a2enmod rewrite

# عدّل إعدادات Apache عشان يسمح بالـ rewrite
RUN echo '<Directory /var/www/html/>\n\
    AllowOverride All\n\
</Directory>' >> /etc/apache2/apache2.conf

# فتح البورت اللي هيشتغل عليه
EXPOSE 80

# الأمر اللي يشغّل السيرفر
CMD ["apache2-foreground"]
