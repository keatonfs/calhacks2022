import cohere

co = cohere.Client("Cm65tYyCQf9sZEmKZY8oEkQCWG6Z8xmCEWhrTmOv")
response = co.generate(prompt='Once upon a time in a magical land called', )
text_response = response.generations[0].text
print(text_response)