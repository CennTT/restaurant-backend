import secrets
from flask import Flask, jsonify
from flask_migrate import Migrate
from models import Beverage, db, Food

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@127.0.0.1/restaurant'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = secrets.token_hex(16)

db.init_app(app)

migrate = Migrate(app, db)

@app.route('/api/v1/foods', methods=['GET'])
def get_foods():
    try:
        foods = Food.query.all()

        food_list = []
        for food in foods:
            food_list.append({
                'id': food.id,
                'name': food.name
            })

        return jsonify({'foods': food_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/api/v1/beverages', methods=['GET'])
def get_beverages():
    try:
        beverages = Beverage.query.all()

        # Serialize the list of beverage items into a JSON response
        beverage_list = []
        for beverage in beverages:
            beverage_list.append({
                'id': beverage.id,
                'name': beverage.name
            })

        return jsonify({'beverages': beverage_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)
