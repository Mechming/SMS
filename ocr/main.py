import cv2
from flask import *
from werkzeug.utils import secure_filename
import pytesseract

from classification import *

WebApp = Flask(__name__)
WebApp.secret_key = "supersmshackerburgsystemtoll"


def image_processing(img_path):
    img = cv2.imread(img_path)
    img = cv2.medianBlur(img,5)
    img = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    text = str(pytesseract.image_to_string(img, lang="deu", config='--oem 1 --psm 6'))
    print("Got Text from Image. Processing...")
    return text


@WebApp.route("/upload", methods=["POST"])
def upload():
    if 'file' not in request.files:
        return jsonify({"error": "No file found"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    if file:
        filename = secure_filename(file.filename)
        print(f"Received File: {filename}")
        file.save(filename)

        image_text = image_processing(filename)
        json = get_products(image_text)
        print("done")
        return json, 200
    print("File not uploaded")
    return jsonify({"error": "File not uploaded"}), 400


if __name__ == '__main__':
    WebApp.run(port=80, host='192.168.137.1')


