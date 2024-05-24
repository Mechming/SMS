import cv2
from flask import *
import pytesseract

WebApp = Flask(__name__)
WebApp.secret_key = "supersmshackerburgsystemtoll"


@WebApp.route("/upload", methods=["POST"])
def upload():
    pass



img = cv2.imread('bill1.jpg')

# Adding custom options
custom_config = r'--oem 3 --psm 6'
pytesseract.image_to_string(img, config=custom_config)


