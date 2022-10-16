import cohere
from flask import Flask
from flask_restful import Resource, Api, reqparse

co = cohere.Client("Cm65tYyCQf9sZEmKZY8oEkQCWG6Z8xmCEWhrTmOv")

# USE: POST request to http://127.0.0.1:5000/generate?prompt=$prompt-goes-here
class BasicPromptGeneration(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('prompt', required=True, location='args')

        args = parser.parse_args()
        response = co.generate(prompt=args['prompt']).generations[0].text
        return {'response': response}, 200

# USE: GET request to http://127.0.0.1:5000/running
class IsRunning(Resource):
    def get(self):
        return {'running': 'true'}

def main():
    app = Flask(__name__)
    api = Api(app)
    api.add_resource(BasicPromptGeneration, '/generate')
    api.add_resource(IsRunning, '/running')
    return app


if __name__ == "__main__":
    main().run()
