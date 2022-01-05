FROM python:3.8-buster

RUN apt-get update \
 && apt-get install -y locales \
 && apt-get update \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && apt-get install -y curl unzip neovim ranger gcc\
 && apt-get install -y poppler-utils\
 && apt-get clean \
 && apt-get autoremove


WORKDIR /app
COPY . /app


RUN pip install -U pip 
RUN pip install -r requirements.txt
RUN pip install  rasa 
RUN pip install  spacy
RUN pip install rasa[transformers]
RUN python -m spacy download en_core_web_lg

RUN chmod -R 777 /app


#RUN python3 -m rasa telemetry disable
#RUN rm -rfv /rasa/*

ENV PORT 5006
ENV PORT2 5002
ENV PORT3 5005
ENV PORT4 5055

EXPOSE $PORT
EXPOSE $PORT2
EXPOSE $PORT3
EXPOSE $PORT4

