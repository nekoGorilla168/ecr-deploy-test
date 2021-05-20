ARG RUNTIME_VERSION="3.8"

FROM python:${RUNTIME_VERSION}-buster as python-buster
# gitのインストール
RUN apt-get install -y git

ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie

WORKDIR /home/app
COPY . /home/app

RUN chmod 755 entry.sh

# runtime interface clientのインストール
RUN pip install awslambdaric

RUN pip install -r requirements.txt

ENTRYPOINT [ "/bin/bash", "entry.sh" ]
CMD [ "/home/app/index.handler" ]


