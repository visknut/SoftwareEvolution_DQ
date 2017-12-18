import flask
import numpy as np
import subprocess
import os

from util.parse_json import *

app = flask.Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    # print(subprocess_cmd('java -Xmx1G -Xss32m -jar rascal/repl_jar/rascal-shell-stable.jar; import IO;'))
    return flask.render_template("index.html")

@app.route("/library", methods=["GET", "POST"])
def libary():
    # print(subprocess_cmd('java -Xmx1G -Xss32m -jar rascal/repl_jar/rascal-shell-stable.jar; import IO;'))
    # return flask.render_template("library.html")
    return flask.render_template('library.html')

@app.route("/library_data", methods=["GET", "POST"])
def library_data():
    json_data = read_to_json('library')
    return str(manipulate_json(json_data))

@app.route("/smallsql", methods=["GET", "POST"])
def smallsql():
    return flask.render_template('smallsql.html')

@app.route("/smallsql_data", methods=["GET", "POST"])
def smallsql_data():
    json_data = read_to_json('smallsql')
    return str(manipulate_json(json_data))

# def subprocess_cmd(command):
#     process = subprocess.Popen(command,stdout=subprocess.PIPE, shell=True)
#     proc_stdout = process.communicate()[0].strip()
#     return proc_stdout

if __name__ == "__main__":

    port = 8001

    # Open a web browser pointing at the app.
    os.system("open http://localhost:{0}".format(port))

    # Set up the development server on port 8000.
    app.debug = True
    app.run(port=port)
