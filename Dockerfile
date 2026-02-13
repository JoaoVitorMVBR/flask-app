FROM python:3.10-slim-bookworm
WORKDIR /usr/local/app
RUN pip3 install flask
COPY app.py ./~
EXPOSE 8080