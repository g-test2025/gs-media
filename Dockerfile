# 1. Choose your base image
FROM alpine:latest

# 2. Install Git
RUN apk add --no-cache git

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 3. Set a working directory inside the container
WORKDIR /

RUN git clone https://github.com/g-test2025/gs-media.git

RUN apk add python3 \
            make \
            g++ \
            alpine-sdk 
COPY Makefile .  

RUN pwd

COPY requirements.txt .


# 4. Install dependencies without saving local download caches
RUN pip install --no-cache-dir -r requirements.txt

RUN make setup

RUN playwright install --with-deps chromium

RUN make run

RUN python manage.py createsuperuser

RUN make admin
