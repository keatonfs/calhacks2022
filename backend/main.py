import cohere
import prompts.introductions
import prompts.take_damage
from flask import Flask
from flask_restful import Resource, Api, reqparse


co = cohere.Client("Cm65tYyCQf9sZEmKZY8oEkQCWG6Z8xmCEWhrTmOv")


# USE: GET request to http://127.0.0.1:5000/announcer?$required-args
# Example curl: curl "http://127.0.0.1:5000/take-damage?name=Keaton&enemy=Demon&health=100"
class TakeDamage(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('name', required=True, location='args')
        parser.add_argument('enemy', required=True, location='args')
        parser.add_argument('health', required=True, location='args')

        args = parser.parse_args()
        base_prompt = prompts.take_damage.prompt.format(args['name'], args['enemy'], args['health'])
        response = co.generate(prompt=base_prompt, max_tokens=100).generations[0].text

        return {'response': response}


# USE: GET request to http://127.0.0.1:5000/announcer?$required-args
# Example curl: curl "http://127.0.0.1:5000/announcer?name=Keaton&pronouns=he/him&descriptions=plain&record=None&nickname=keaty"
class Announcer(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('name', required=True, location='args')
        parser.add_argument('pronouns', required=True, location='args')
        parser.add_argument('descriptions', required=True, location='args')
        parser.add_argument('record', required=True, location='args')
        parser.add_argument('nickname', required=True, location='args')

        args = parser.parse_args()
        base_prompt = prompts.introductions.prompt.format(args['name'], args['pronouns'], args['descriptions'], args['record'], args['nickname'])
        response = co.generate(prompt = base_prompt, max_tokens=100).generations[0].text
        
        return {'response': response}


# USE: GET request to http://127.0.0.1:5000/generate?prompt=$prompt-goes-here
# Example curl: curl "http://127.0.0.1:5000/generate?prompt=test"
class BasicPromptGeneration(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('prompt', required=True, location='args')

        args = parser.parse_args()
        response = co.generate(prompt=args['prompt']).generations[0].text
        return {'response': response}, 200


# USE: GET request to http://127.0.0.1:5000/running
# Example curl: curl http://127.0.0.1:5000/running
class IsRunning(Resource):
    def get(self):
        return {'running': 'true'}


def main():
    app = Flask(__name__)
    api = Api(app)

    api.add_resource(IsRunning, '/running')
    api.add_resource(BasicPromptGeneration, '/generate')
    api.add_resource(Announcer, '/announcer')
    api.add_resource(TakeDamage, '/take-damage')

    return app


if __name__ == "__main__":
    main().run()
