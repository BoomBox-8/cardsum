from django.db import models # type: ignore
from django.utils import timezone # type: ignore
from django.contrib.auth.models import User # type: ignore
import json
from rest_framework_simplejwt.tokens import RefreshToken, AccessToken


# Create your models here.
class Post(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    date_posted = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.title
    

class FlashcardsManager():
    
    @staticmethod
    def create_flashcard(request): #using snake case against my will
        data = json.loads(request.body)
     

        token = data.get('authToken')
        userID = AccessToken(token)['user_id']
        userObj = User.objects.get(id = userID)

        topic = data.get('topic')
        title = data.get('title')
        text = data.get('text')


        flashcard = Flashcard(user = userObj, topic = topic, title = title, text = text)
        flashcard.save()
        return flashcard


    @staticmethod
    def get_flashcards(user_id):
        
        flashcards = Flashcard.objects.filter(user_id=user_id)
        return flashcards
    
    @staticmethod
    def get_flashcard(flashcard_id): #ONE, JUST ONE, NOT MORE NOT LESS
        
        flashcard = Flashcard.objects.get(id=flashcard_id)
        return flashcard
    

    @staticmethod
    def update_flashcard(flashcard_id, topic = None, title=None, text=None, ):
        
        flashcard = Flashcard.objects.get(id=flashcard_id)
        if title:
            flashcard.title = title
        if topic:
            flashcard.topic = topic
        if text:
            flashcard.text = text
        
        
        flashcard.save()
        return flashcard
        

    @staticmethod
    def delete_flashcard(flashcard_id):
   
        flashcard = Flashcard.objects.get(id=flashcard_id)
        flashcard.delete()
        return True



class Flashcard(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    topic = models.CharField(max_length=200)
    title = models.CharField(max_length=200)
    text = models.CharField(max_length=200)

    def __str__(self):
        return self.title