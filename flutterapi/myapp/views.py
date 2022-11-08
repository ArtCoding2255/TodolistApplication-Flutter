from django.shortcuts import render
from django.http import JsonResponse


from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status 
from .serializers import TodolistSerializer
from .models import Todolist


#Get data 
@api_view(['GET'])
def all_todolist(request):
  allTodoList = Todolist.objects.all() #select * from todolist
  serializer = TodolistSerializer(allTodoList,many=True)
  return Response(serializer.data, status=status.HTTP_200_OK)

#POST Data (save to database)
@api_view(['POST'])
def post_todolist(request):
  if request.method == 'POST':
      serializer = TodolistSerializer(data=request.data)
      if serializer.is_valid():
          serializer.save()
          return Response(serializer.data,status=status.HTTP_201_CREATED)
      return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

#PUT Data
@api_view(['PUT'])
def update_todolist(request,TID):
  #api/update-todolist/id
  todo = Todolist.objects.get(id=TID) #fetch object has id = TID from database
  if request.method == 'PUT':
    data = {}
    serializer = TodolistSerializer(todo,data=request.data) #get data
    if serializer.is_valid():
        serializer.save()
        data['status'] = 'updated'
        return Response(data=data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)


#DELETE Data
@api_view(['DELETE'])
def delete_todolist(request,TID):
  todo = Todolist.objects.get(id=TID)
  if request.method == 'DELETE':
    delete = todo.delete()
    data = {}
    if delete:
      data['status'] = 'deleted'
      statuscode = status.HTTP_200_OK
    else:
      data['status'] = 'failed'
      statuscode = status.HTTP_400_BAD_REQUEST
    return Response(data=data,status=statuscode)


data = [
  {
    "title": "คอมพิวเตอร์คืออะไร ?",
    "subtitle": "คอมพิวเตอร์ คือ อุปกรณ์ที่ใช้สำหรับการคำนวณแอพทำงานอื่นๆ",
    "image_url": "https://raw.githubusercontent.com/ArtCoding2255/FlutterBasicAPI/main/computer.jpg",
    "detail": "คอมพิวเตอร์ (อังกฤษ: computer) หรือศัพท์บัญญัติราชบัณฑิตยสภาว่า คณิตกรณ์[2][3] เป็นเครื่องจักรแบบสั่งการได้ที่ออกแบบมาเพื่อดำเนินการกับลำดับตัวดำเนินการทางตรรกศาสตร์หรือคณิตศาสตร์ โดยอนุกรมนี้อาจเปลี่ยนแปลงได้เมื่อพร้อม ส่งผลให้คอมพิวเตอร์สามารถแก้ปัญหาได้มากมาย\n\nคอมพิวเตอร์ถูกประดิษฐ์ออกมาให้ประกอบไปด้วยความจำรูปแบบต่าง ๆ เพื่อเก็บข้อมูล อย่างน้อยหนึ่งส่วนที่มีหน้าที่ดำเนินการคำนวณเกี่ยวกับตัวดำเนินการทางตรรกศาสตร์ และตัวดำเนินการทางคณิตศาสตร์ และส่วนควบคุมที่ใช้เปลี่ยนแปลงลำดับของตัวดำเนินการโดยยึดสารสนเทศที่ถูกเก็บไว้เป็นหลัก อุปกรณ์เหล่านี้จะยอมให้นำเข้าข้อมูลจากแหล่งภายนอก และส่งผลจากการคำนวณตัวดำเนินการออกไป"
  },
  {
    "title": "มาเขียนโปรแกรมกัน",
    "subtitle": "",
    "image_url":"https://raw.githubusercontent.com/ArtCoding2255/FlutterBasicAPI/main/learn%20coding.jpg",
    "detail": "ภาษาโปรแกรม คือภาษาประดิษฐ์ชนิดหนึ่งที่ออกแบบขึ้นมาเพื่อสื่อสารชุดคำสั่งแก่เครื่องจักร โดยเฉพาะอย่างยิ่งคอมพิวเตอร์ ภาษาโปรแกรมสามารถใช้สร้างโปรแกรมที่ควบคุมพฤติกรรมของเครื่องจักร และ/หรือ แสดงออกด้วยขั้นตอนวิธี (algorithm) อย่างตรงไปตรงมา ผู้เขียนโปรแกรมซึ่งหมายถึงผู้ที่ใช้ภาษาโปรแกรมเรียกว่า โปรแกรมเมอร์ (programmer)\n\nภาษาโปรแกรมในยุคแรกเริ่มนั้นเกิดขึ้นก่อนที่คอมพิวเตอร์จะถูกประดิษฐ์ขึ้น โดยถูกใช้เพื่อควบคุมการทำงานของเครื่องทอผ้าของแจ็กการ์ดและเครื่องเล่นเปียโน ภาษาโปรแกรมต่าง ๆ หลายพันภาษาถูกสร้างขึ้นมา ส่วนมากใช้ในวงการคอมพิวเตอร์ และสำหรับวงการอื่นภาษาโปรแกรมก็เกิดขึ้นใหม่ทุก ๆ ปี ภาษาโปรแกรมส่วนใหญ่อธิบายการคิดคำนวณในรูปแบบเชิงคำสั่ง อาทิลำดับของคำสั่ง ถึงแม้ว่าบางภาษาจะใช้การอธิบายในรูปแบบอื่น ตัวอย่างเช่น ภาษาที่สนับสนุนการเขียนโปรแกรมเชิงฟังก์ชัน หรือการเขียนโปรแกรมเชิงตรรกะ"
  },
  {
    "title": "Flutter คือ",
    "subtitle": "",
    "image_url": "https://raw.githubusercontent.com/ArtCoding2255/FlutterBasicAPI/main/flutter.jpg",
    "detail": "Flutter คือ SDK สำหรับพัฒนา Application บน Mobile ซึ่งพัฒนาโดย Google โดย Flutter นั้นสามารถ build ไปยัง iOS และ Android ได้ด้วยการเขียนเพียงครั้งเดียว "
  },
  {
    "title": "flutter is framework ",
    "subtitle": "",
    "image_url": "https://raw.githubusercontent.com/ArtCoding2255/FlutterBasicAPI/main/computer.jpg",
    "detail": ""
  }
]

def Home(request):
    return JsonResponse(data=data,safe=False, json_dumps_params={'ensure_ascii': False})
