import cv2
from flask import *
from werkzeug.utils import secure_filename
import pytesseract

from classification import *


WebApp = Flask(__name__)
WebApp.secret_key = "supersmshackerburgsystemtoll"


@WebApp.route("/upload", methods=["POST"])
def upload():
    if 'file' not in request.files:
        return jsonify({"error": "No file found"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    if file:
        filename = secure_filename(file.filename)
        file.save(f"/uploads/{filename}")

        # image processing

        return jsonify({"message": "data"}), 200
    return jsonify({"error": "File not uploaded"}), 400


img = cv2.imread('bill1.jpg')
#text = str(pytesseract.image_to_string(img, lang="deu", config='--oem 1 --psm 6'))
#print(text)

if __name__ == '__main__':
    WebApp.run(debug=True, port=80, host='192.168.137.1')

#get_products(text)