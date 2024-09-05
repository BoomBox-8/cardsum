import json

from django.shortcuts import render #type: ignore
from .models import Post, FlashcardsManager
from django.http import HttpResponse
from django.http import JsonResponse
from django.contrib.auth import authenticate

from django.views.decorators.csrf import csrf_exempt
from ai_summ import summarizer
from ai_summ import summarizerv2
from django.contrib.auth.models import User
from rest_framework_simplejwt.tokens import RefreshToken, AccessToken
from rest_framework.decorators import api_view
from rest_framework_simplejwt.authentication import JWTAuthentication

#stupid stuff, should really import over models?
#only damn reason I have these is for the tokens
#maybe sessions would have been a better idea?

# Create your views here.

def home(request):
    context = {
        'posts': Post.objects.all()
    }
    return render(request, 'summ/home.html', context)

@csrf_exempt
def about(request):
    body = request.body.decode('utf-8')
    print(body)
    print((request.body))
    return HttpResponse(body.upper())


@csrf_exempt
def summarize(request):
    bodyText = request.body.decode('utf-8')
    return HttpResponse(summarizerv2.plaintext_summarizer(bodyText))

@csrf_exempt
def questionGenerate(request):
    #bodyText = request.body.decode('utf-8')
    pass

@csrf_exempt
def login(request):

    if request.method == "POST":
        data = json.loads(request.body)
        name = data.get('username')
        passKey = data.get('password')
         

        if not User.objects.filter(username=name).exists(): #user doesn't exist

            return JsonResponse({"error" : "Invalid User"}, status = 400)

        user = authenticate(username=name, password=passKey) #
         
        if user is None: #This stupid thing is going to make me work with json 

            return JsonResponse({"error" : "Invalid Pass"},  status = 400)
        
        else:

            refresh = RefreshToken.for_user(user)

            return JsonResponse({"accessToken" : str(refresh.access_token), "message" : "Authenticated Successfully"},  status = 200)
     

 

@csrf_exempt
def registerUser(request):
    if request.method == "POST":
        data = json.loads(request.body)
        name = data.get('username')
        passKey = data.get('password')

        user = User.objects.create_user(username = name, password = passKey) #stores a nice hashed pass so I don't have to muck about with SDAs
        user.save() #should register, have a check to check for existing accounts
        return JsonResponse({"message" : "Registered Successfully"},  status = 200)
        #hopefully this saves it over in the DB


    else:
        return JsonResponse({"error" : "Registration Failed Due To Unspecified Reasons"},  status = 400)


@api_view(['POST'])
@csrf_exempt
def getUserInfo(request):
    # The user is authenticated, so you can access the user instance directly
    data = json.loads(request.body)
    print(data)
    token = data.get('authToken')
    print(token)

    # Retrieve the username from the user object
    userID = AccessToken(token)['user_id']
    user = User.objects.get(id = userID)

    username = user.username
    print(username)

    return JsonResponse({'username': username}, status=200)

@api_view(['POST'])
@csrf_exempt
def registerFlashcard(request):
    if request.method == "POST":
        flashcard = FlashcardsManager.create_flashcard(request) 
        flashcard.save() 
        ''' data = json.loads(request.body)

        userid = data.get('user_id')
        title = data.get('title')
        topic = data.get('topic')
        text = data.get('topic')'''

        

        return JsonResponse({"message" : "Flashcard Created Successfully"},  status = 200)
        #hopefully this saves it over in the DB


    else:
        return JsonResponse({"error" : "Flashcard Creation Failed Due To Unspecified Reasons"},  status = 400)
    

@api_view(['POST'])
@csrf_exempt
def getFlashcards(request):
    if request.method == "POST":
        data = json.loads(request.body)

        userid = data.get('user_id')
        


        flashcards = FlashcardsManager.get_flashcards(userid)
    

        return JsonResponse({"message" : "Flashcard Created Successfully"},  status = 200)
        #hopefully this saves it over in the DB
        #get back to this later, need to find out how to provide a JSON file of all flashcards and use a listBuilder to build them

    else:
        return JsonResponse({"error" : "Flashcard Creation Failed Due To Unspecified Reasons"},  status = 400)
    

@api_view(['POST'])
@csrf_exempt
def getFlashcard(request):
    if request.method == "POST":
        data = json.loads(request.body)

        flashcardId = data.get('flashcardId')
        


        flashcard = FlashcardsManager.get_flashcard(flashcardId)
    

        return JsonResponse({"topic" : flashcard.title, "title" : flashcard.title, "text" : flashcard.text},  status = 200)


    else:
        return JsonResponse({"error" : "Flashcard Creation Failed Due To Unspecified Reasons"},  status = 400)
    