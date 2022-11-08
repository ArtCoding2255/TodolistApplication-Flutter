#serializers.py
#กำหนดว่า field ไหนที่เราอยากใช้ในการจัดการข้อมูลเกี่ยวกับ api บ้าง
from rest_framework import serializers
from .models import Todolist

 
class TodolistSerializer(serializers.ModelSerializer):
    class Meta:
        model  = Todolist
        fields = ('id','title','detail') 