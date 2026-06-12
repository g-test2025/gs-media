# 1. Choose your base image
FROM alpine:latest

# 2. Install Git
RUN apk add --no-cache git

# 3. Set a working directory inside the container
WORKDIR /

RUN git clone https://github.com/g-test2025/gs-media.git

RUN ln -sf /usr/bin/python3 /usr/bin/python

RUN python -m venv venv

RUN source venv/bin/activate

RUN make setup

RUN playwright install --with-deps chromium

RUN make run

RUN python manage.py createsuperuser

RUN make admin
