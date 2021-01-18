import psycopg2
import os

from flask import Flask


app = Flask(__name__)


def get_conexion():
	info = ''
	user = os.getenv('POSTGRES_USER','a')
	password = os.getenv('POSTGRES_PASSWORD','a')
	#host = os.getenv('DB_HOST','localhost')
	port = os.getenv('DB_PORT','a')
	database = os.getenv('POSTGRES_DB','a')
	try:
		# connection = psycopg2.connect(
		# 	user=user, password=password, 
		# 	host=host, port=port, database=database)
		#SAME CONTAINER no use host 
		connection = psycopg2.connect(
			user=user, password=password, port=port, database=database)
		info = str(connection.get_dsn_parameters())
		connection.close()
	except:
		info = 'ERROR' + user + password + port + database
	return info


@app.route('/', methods=['GET'])
def index():
	conexion = get_conexion()
	return {
		'mensaje': 'Hola mundo', 
		'conexion': conexion
	}


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000)
