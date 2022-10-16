import cohere
import prompts.introductions
import prompts.take_damage
import prompts.kill_enemy
import prompts.player_dies
from flask import Flask
from flask_restful import Resource, Api, reqparse


co = cohere.Client("Cm65tYyCQf9sZEmKZY8oEkQCWG6Z8xmCEWhrTmOv")


# USE: GET request
# Example curl: curl "http://127.0.0.1:5000/player-dies?name=Saurabh&enemy=Ghost"
class PlayerDies(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('name', required=True, location='args')
        parser.add_argument('enemy', required=True, location='args')

        args = parser.parse_args()
        base_prompt = prompts.player_dies.prompt.format(args['name'], args['enemy'])
        response = co.generate(prompt=base_prompt, max_tokens=100).generations[0].text

        return response_cleaner(response)


# USE: GET request
# Example curl: curl "http://127.0.0.1:5000/kill-enemy?name=Abhi&enemy=demon"
class KillEnemy(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('name', required=True, location='args')
        parser.add_argument('enemy', required=True, location='args')

        args = parser.parse_args()
        base_prompt = prompts.kill_enemy.prompt.format(args['name'], args['enemy'])
        response = co.generate(prompt=base_prompt, max_tokens=100).generations[0].text

        return response_cleaner(response)


# USE: GET request
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

        return response_cleaner(response)


# USE: GET request
# Example curl: curl "http://127.0.0.1:5000/announcer?name=Keaton&pronouns=he/him&descriptions=plain&record=None&nickname=Keaty"
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

        return response_cleaner(response)


# USE: GET request
# Example curl: curl "http://127.0.0.1:5000/generate?prompt=test"
class BasicPromptGeneration(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('prompt', required=True, location='args')

        args = parser.parse_args()
        response = co.generate(prompt=args['prompt']).generations[0].text
        return response


# USE: GET request
# Example curl: curl http://127.0.0.1:5000/running
class IsRunning(Resource):
    def get(self):
        return {'running': 'true'}


# Cleans the response of our specific cohere prompt generations used in game
def response_cleaner(string):
    cleaned = string.split('\n\n')[0]
    cleaned = cleaned.lstrip()
    return cleaned


def main():
    app = Flask(__name__)
    api = Api(app)

    api.add_resource(IsRunning, '/running')
    api.add_resource(BasicPromptGeneration, '/generate')
    api.add_resource(Announcer, '/announcer')
    api.add_resource(TakeDamage, '/take-damage')
    api.add_resource(KillEnemy, '/kill-enemy')
    api.add_resource(PlayerDies, '/player-dies')

    return app


if __name__ == "__main__":
    main().run()
