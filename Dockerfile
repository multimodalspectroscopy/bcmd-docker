FROM python:2-alpine

ADD hello_world.py /

CMD [ "python", "/hello_world.py" ]

# TODO dockerignore file
# TODO check directory structure and then mkdir 
