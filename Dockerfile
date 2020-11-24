FROM python:latest
COPY src/project-state.py /tmp/project-state.py
RUN pip install PyGithub
RUN pip install slackclient
RUN pip install markdown
RUN pip install html-slacker
CMD ["python", "/tmp/project-state.py"]
