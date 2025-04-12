# from django.contrib import admin #type: ignore
# from .models import *

# # Register your models here.
# admin.site.register(Movie)
# admin.site.register(Actor)
# admin.site.register(Review)
# admin.site.register(Episode)

from django.contrib import admin  # type: ignore
from .models import Movie, Actor, Review, Episode  # import rõ ràng

@admin.register(Movie)
class MovieAdmin(admin.ModelAdmin):
    list_display = ('name', 'is_featured')  # hiển thị ở danh sách
    list_filter = ('is_featured',)          # bộ lọc bên phải
    search_fields = ('name',)
    fields = ('name', 'image', 'description', 'is_featured', 'actors')  # hiển thị trong form

# Đăng ký các model khác
admin.site.register(Actor)
admin.site.register(Review)
admin.site.register(Episode)
