import secrets
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_migrate import Migrate
from models import db, FoodAndBeverage, Order, OrderItem

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@127.0.0.1/restaurant'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = secrets.token_hex(16)

CORS(app, resources={r"/api/*": {"origins": "http://localhost:8080"}})

db.init_app(app)

migrate = Migrate(app, db)

@app.route('/api/v1/create-foodnbaverage', methods=['POST'])
def create_new_food_or_beverage():
    try:
        data = request.json
        name = data.get('name')
        item_type = data.get('type')
        price = data.get('price')
        path = data.get('path')

        new_item = FoodAndBeverage(name=name, type=item_type, price=price, path=path)
        db.session.add(new_item)
        db.session.commit()

        return jsonify({'message': 'Item created successfully!', 'id': new_item.id}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/api/v1/foodnbaverages', methods=['GET'])
def get_foods():
    try:
        food_n_baverage = FoodAndBeverage.query.all()

        food_n_baverage_list = []
        for item in food_n_baverage:
            food_n_baverage_list.append({
                'id': item.id,
                'name': item.name,
                'type': item.type,
                'price': item.price,
                'path': item.path
            })
        return jsonify({'foods': food_n_baverage_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/api/v1/foodnbaverages/<int:item_id>', methods=['PUT'])
def update_food_or_beverage(item_id):
    try:
        data = request.json
        name = data.get('name')
        item_type = data.get('type')
        price = data.get('price')
        path = data.get('path')

        item = FoodAndBeverage.query.get(item_id)
        if not item:
            return jsonify({'message': 'Item not found!'}), 404

        if name:
            item.name = name
        if item_type:
            item.type = item_type
        if price:
            item.price = price
        if path:
            item.path = path

        db.session.commit()

        return jsonify({'message': 'Item updated successfully!'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/api/v1/foodnbaverages/<int:item_id>', methods=['DELETE'])
def delete_food_or_beverage(item_id):
    try:
        item = FoodAndBeverage.query.get(item_id)
        if not item:
            return jsonify({'message': 'Item not found!'}), 404

        db.session.delete(item)
        db.session.commit()

        return jsonify({'message': 'Item deleted successfully!'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

    

@app.route('/api/v1/orders', methods=['POST'])
def create_order():
    try:
        data = request.json
        table_number = data.get('table_number')
        items = data.get('items')
        total_price = data.get('total_price')
        status = data.get('status', 'open')  

        new_order = Order(table_number=table_number, status=status, total_price=total_price)
        for item in items:
            order_item = OrderItem(quantity=item['quantity'], item_id=item['item_id'])
            new_order.items.append(order_item)

        db.session.add(new_order)
        db.session.commit()

        return jsonify({'message': 'Order created successfully!'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
    
@app.route('/api/v1/orders/<int:table_number>', methods=['PUT'])
def edit_order(table_number):
    try:
        data = request.json
        items = data.get('items', [])

        order = Order.query.filter_by(table_number=table_number).first()
        if not order:
            return jsonify({'message': 'Order not found for the given table number!'}), 404

        for item in items:
            item_id = item.get('item_id')
            quantity = item.get('quantity')

            existing_order_item = OrderItem.query.filter_by(order_id=order.id, item_id=item_id).first()

            if existing_order_item:
                existing_order_item.quantity += quantity
            else:
                new_order_item = OrderItem(quantity=quantity, item_id=item_id)
                order.items.append(new_order_item)

        db.session.commit()

        return jsonify({'message': 'Order updated successfully!'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/api/v1/orders', methods=['GET'])
def get_orders():
    try:
        orders = Order.query.all()

        orders_list = []
        for order in orders:
            order_items = [{
                'item_id': order_item.item_id,
                'quantity': order_item.quantity
            } for order_item in order.items]

            orders_list.append({
                'id': order.id,
                'table_number': order.table_number,
                'status': order.status,
                'items': order_items
            })

        return jsonify({'orders': orders_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/orders/<int:order_id>', methods=['PUT'])
def update_order_status(order_id):
    try:
        data = request.json
        status = data.get('status')

        order = Order.query.get(order_id)
        if not order:
            return jsonify({'message': 'Order not found!'}), 404

        order.status = status
        db.session.commit()

        return jsonify({'message': 'Order status updated successfully!'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/v1/orders/<int:order_id>', methods=['DELETE'])
def delete_order(order_id):
    try:
        order = Order.query.get(order_id)
        if not order:
            return jsonify({'message': 'Order not found!'}), 404

        db.session.delete(order)
        db.session.commit()

        return jsonify({'message': 'Order deleted successfully!'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
