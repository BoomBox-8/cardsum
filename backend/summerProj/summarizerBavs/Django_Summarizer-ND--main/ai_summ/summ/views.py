from django.shortcuts import render #type: ignore
from .models import Post
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

#import filename

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
    #return filename.summarize(bodyText)

@csrf_exempt
def questionGenerate(request):
    #bodyText = request.body.decode('utf-8')
    pass