#build phase
FROM postgres
CMD ["postgres"]

#/var/lib/postgresql/data/ <--- has all the output files needed for RUN PHASE


FROM postgres

#update repositories
RUN apt-get update -y

#apt utilities
RUN apt-get install -y apt-utils
#RUN apt-get install -y sudo

#install python3
RUN apt-get install -y python3
RUN apt-get install -y python3-pip

#dependencies
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
#ENV DB_USER=postgres
ENV POSTGRES_USER=postgres
#ENV DB_PASS=hello1234
ENV DB_HOST=localhost
ENV DB_PORT=5432
#ENV DB_NAME=postgres
ENV POSTGRES_DB=postgres

#copying script
COPY postgres_script.sh .
COPY pythonapp_script.sh .
COPY wrapper_script.sh .

RUN ["chmod", "+x", "./wrapper_script.sh"]
RUN ["chmod", "+x", "./postgres_script.sh"]
RUN ["chmod", "+x", "./pythonapp_script.sh"]

#command to be executed when container starts
USER postgres
#CMD ["postgres"]

#copying files needed to run postgres
	#copy      from:                     to:
COPY --from=0 /var/lib/postgresql/data/ /var/lib/postgresql/data/

CMD ./wrapper_script.sh

#USER root
#CMD python3 app.py

EXPOSE 5000