from django.contrib import admin # type: ignore
from .models import Post # type: ignore

# Register your models here.

admin.site.register(Post)