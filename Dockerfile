FROM python:3.8.13-slim-bullseye

WORKDIR /app

RUN apt-get -y update  && apt-get install -y \
  python3-dev \
  apt-utils \
  python-dev \
  tesseract-ocr \
  build-essential \
&& rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools 
    
COPY requirements.txt .

RUN pip install -r requirements.txt 

COPY . .

EXPOSE 8000:8000

CMD cd src && gunicorn -w 3 -k uvicorn.workers.UvicornWorker app:app --bind 0.0.0.0:$PORT