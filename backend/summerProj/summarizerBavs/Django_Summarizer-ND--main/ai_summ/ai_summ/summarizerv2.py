import spacy 
nlp = spacy.load("en_core_web_sm")

from spacy.lang.en.stop_words import STOP_WORDS
from string import punctuation

from heapq import nlargest
from openai import OpenAI
import random
#import PyPDF2 -> will deal with this later


def print_pdf_text_to_file(pdf_path, output_file):

  with open(pdf_path, 'rb') as pdf_file, open(output_file, 'w') as text_file:
    reader = PyPDF2.PdfReader(pdf_file)

    for page_num in range(len(reader.pages)):
      page = reader.pages[page_num]
      extracted_text = page.extract_text()
      text_file.write(extracted_text.replace("\n", " "))


def read_file(filename):
    """Reads text from a file and returns its content as a string."""
    try:
        with open(filename, 'r') as file:
            text = file.read()
        return text
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        return None
    

def text_summarizer(filename):
        raw_text=read_file(filename)
        if raw_text is None:
            return
        #raw_text = raw_docx
        docx = nlp(raw_text)
        stopwords = list(STOP_WORDS)
        # Build Word Frequency # word.text is tokenization in spacy
        word_frequencies = {}  
        for word in docx:  
            if word.text not in stopwords:
                if word.text not in word_frequencies.keys():
                    word_frequencies[word.text] = 1
                else:
                    word_frequencies[word.text] += 1


        maximum_frequncy = max(word_frequencies.values())

        for word in word_frequencies.keys():  
            word_frequencies[word] = (word_frequencies[word]/maximum_frequncy)
        # Sentence Tokens
        sentence_list = [ sentence for sentence in docx.sents ]

        # Sentence Scores
        sentence_scores = {}  
        for sent in sentence_list:  
            for word in sent:
                if word.text.lower() in word_frequencies.keys():
                    if len(sent.text.split(' ')) < 30:
                        if sent not in sentence_scores.keys():
                            sentence_scores[sent] = word_frequencies[word.text.lower()]
                        else:
                            sentence_scores[sent] += word_frequencies[word.text.lower()]


        summarized_sentences = nlargest(7, sentence_scores, key=sentence_scores.get)
        final_sentences = [ w.text for w in summarized_sentences ]
        summary = ' '.join(final_sentences)
        return summary


def plaintext_summarizer(text):

        if text is None:
            return
      
        docx = nlp(text)
        stopwords = list(STOP_WORDS)
        
        word_frequencies = {}  
        for word in docx:  
            if word.text not in stopwords:
                if word.text not in word_frequencies.keys():
                    word_frequencies[word.text] = 1
                else:
                    word_frequencies[word.text] += 1


        maximum_frequncy = max(word_frequencies.values())

        for word in word_frequencies.keys():  
            word_frequencies[word] = (word_frequencies[word]/maximum_frequncy)
   
        sentence_list = [ sentence for sentence in docx.sents ]


        sentence_scores = {}  
        for sent in sentence_list:  
            for word in sent:
                if word.text.lower() in word_frequencies.keys():
                    if len(sent.text.split(' ')) < 30:
                        if sent not in sentence_scores.keys():
                            sentence_scores[sent] = word_frequencies[word.text.lower()]
                        else:
                            sentence_scores[sent] += word_frequencies[word.text.lower()]


        summarized_sentences = nlargest(7, sentence_scores, key=sentence_scores.get)
        final_sentences = [ w.text for w in summarized_sentences ]
        summary = ' '.join(final_sentences)

        summarizerContainerObj = summarizerContainer()
        summarizerContainerObj.generate_questions(summary)


        return f'{summary}\n'








class summarizerContainer():
    
    def __init__(self): #pass a client handle to an instance of this
        
        self.questionsDict = {} #really shouldn't be here
        self.points=0
        self.clientObj = OpenAI()

    #TEXT SUMMARIZER CODE USING SPACY
    
    #QUESTION GENERATOR USING OPEN AI HERE
   
    def generate_questions(self, text):
        """
        Reads text from a file, sends it to OpenAI, and generates multiple-choice
        questions testing reading comprehension on the topic.
        """
       
        if text is None:
            return

        completion = self.clientObj.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You will be provided with a big text. You must then generate several multiple-choice questions testing one's reading comprehension on that topic. There should be 4 choices. In the final line should be the answer from one of the four choices. So totally 6 lines of text. Generate atleast five questions"},
                {"role": "user", "content": text},
            ]
        )

        questions = completion.choices[0].message.content.split("\n\n")
        #print(f"Comprehension Questions:\n")
        totalText = ''
        mcqDict = {}
        for question in questions:
            lines = question.strip().splitlines()
            #print(lines)


            if len(lines) < 3:
                print(f"Error: Invalid question format: {question}")
                continue


            question_text = lines[0]
            choices = lines[1:-1]
            option = lines[-1].split(": ")[-1]

            
            #print(option[0])
            #print(f"{question_text}")
            totalText = question_text
            choiceText = ''
            for i, choice in enumerate(choices):
                choiceText += "\n" + choice


            mcqDict[totalText] = {choiceText : option}
            
            

        return mcqDict
            #print("this?",option[0])
            #print(f"{option}")
            #self.questionsDict[question_text]=option[0]
        
    def generate_flashcards(self, text, num_flashcards=5):
 
        if text is None:
            return {}

        completion = self.clientObj.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": f"""You will be provided with a large text. Generate exactly {num_flashcards} flashcards. Each card should provide a topic and a content summary.The topic can be any keyword from the text and the summary should briefly explain the topic.

    Use only plain text throughout. Separate the topic and summary with a newline."""},
                {"role": "user", "content": text},
            ]
        )

        flashcards = completion.choices[0].message.content.split("\n\n")
        
        flashcards_dict = {}
        for card in flashcards:
            lines = card.strip().split("\n")
            if len(lines) >= 2:
                topic = lines[0].strip()
                summary = lines[1].strip()
                flashcards_dict[topic] = summary

        return flashcards_dict
    

    def generate_simple_summary(self, text):
        if text is None:
            return {}

        completion = self.clientObj.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": f"""You will be provided with a large text. Provide a simple summary that a 10 year old child can understand. Use analogies simple language."""},
                {"role": "user", "content": text},
            ]
        )

        return completion.choices[0].message.content


    

    
            
            
            

        
#clientObj = OpenAI()

#summarizerContainerObj = summarizerContainer(clientObj)
#print(text_summarizer(output_file))
#summarizerContainerObj.generate_questions(output_file)