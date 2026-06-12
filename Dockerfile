# 1. Choose your base image
FROM alpine:latest

# 2. Install Git
RUN apk add --no-cache git

# 3. Set a working directory inside the container
WORKDIR /OpenOutreach

RUN git clone https://github.com/g-test2025/gs-media.git

RUN apk add python3 \
            make \
            g++ \
            alpine-sdk 

RUN make setup

RUN playwright install --with-deps chromium

RUN make run

RUN python manage.py createsuperuser

RUN make admin
