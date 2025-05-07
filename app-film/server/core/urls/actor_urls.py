from django.urls import path #type: ignore
from core.views import actor_views as views

urlpatterns = [
    path('', views.getActors, name="actors"),
    path('<str:pk>/', views.getActor, name="actor"),
]