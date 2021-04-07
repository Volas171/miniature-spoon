FROM python:3.9.4

ENV USER=miniaturespoon

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/miniature-spoon -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/miniature-spoon

COPY package*.json ./
RUN pip3 install -r requirements.txt
VOLUME [ "/home/miniature-spoon" ]

COPY . .

ENTRYPOINT [ "python3", "main.py" ]
