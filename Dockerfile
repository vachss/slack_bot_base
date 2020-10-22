FROM python:3.8.0-alpine

RUN apk --no-cache add tzdata build-base libffi-dev openssl-dev openssl && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata

ADD requirements.txt /
RUN pip install --upgrade pip && pip install -r /requirements.txt

COPY src /src
WORKDIR /src

ENTRYPOINT ["python3"]
CMD ["main.py"]
