FROM python:3.5.6

WORKDIR /app

COPY requirements.txt /app
COPY templates /app
COPY tests /app
COPY .gitinore /app
COPY app.py /app
COPY config.py /app
COPY model_saved /app
COPY READMe.md /app
COPY requirements.txt /app

#dependencies
RUN pip install -r requirements.txt



ENV POSTGRES_PASSWORD=1234
ENV POSTGRES_USER=user
ENV POSTGRES_DB=db
ENV USE_POSTGRES=true

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh

ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

COPY Dockerfile /app
COPY docker-compose /app

CMD ["python","app.py","runserver","host=0.0.0.0","--threaded"]

