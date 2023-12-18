from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class FoodAndBeverage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    type = db.Column(db.String(20))
    price = db.Column(db.Float)
    path = db.Column(db.String(255))

    def __repr__(self):
        return f'<Item {self.name} - Type: {self.type}>'

class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    table_number = db.Column(db.Integer)
    status = db.Column(db.String(20))
    total_price = db.Column(db.Float, default=0)
    items = db.relationship('OrderItem', backref='order')

class OrderItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.Integer, db.ForeignKey('order.id'))
    item_id = db.Column(db.Integer, db.ForeignKey('food_and_beverage.id'))
    quantity = db.Column(db.Integer)
