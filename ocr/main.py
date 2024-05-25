import cv2
from flask import *
import pytesseract

WebApp = Flask(__name__)
WebApp.secret_key = "supersmshackerburgsystemtoll"


@WebApp.route("/upload", methods=["POST"])
def upload():
    pass


img = cv2.imread('bill1.jpg')

text = str(pytesseract.image_to_string(img, lang="deu", config='--oem 1 --psm 6'))
print(text)

