FROM postgres

#update repositories
RUN apt-get update -y

#dependencies
RUN apt-get install -y python3-pip
RUN apt-get install libpq-dev -y

#directories
RUN mkdir /app
WORKDIR /app

ADD requirements.txt .
RUN pip3 install -r requirements.txt
#adding the rest of source code
ADD . .

#env variables
ENV POSTGRES_PASSWORD=hello1234
ENV POSTGRES_USER=postgres
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV POSTGRES_DB=postgres

#copying script to postgres script entry point folder
COPY pythonapp_script.sh /docker-entrypoint-initdb.d

#RUN ["chmod", "+x", "/docker-entrypoint-initdb.d/pythonapp_script.sh"]

#command to be executed when container starts

CMD ["postgres"]

EXPOSE 5000