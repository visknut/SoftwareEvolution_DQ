import json
import flask
import numpy as np
import subprocess
import os

app = flask.Flask(__name__)


@app.route("/")
def index():
    # print(subprocess_cmd('java -Xmx1G -Xss32m -jar rascal/repl_jar/rascal-shell-stable.jar; import IO;'))
    return flask.render_template("index.html")

@app.route("/library")
def libary():
    # print(subprocess_cmd('java -Xmx1G -Xss32m -jar rascal/repl_jar/rascal-shell-stable.jar; import IO;'))
    # return flask.render_template("library.html")
    return read_to_json('library')


@app.route("/library_data")
def data(ndata=100):
    # print(subprocess_cmd('java -Xmx1G -Xss32m -jar rascal/repl_jar/rascal-shell-stable.jar; :quit;'))
    return read_to_json('library')
    # x = 10 * np.random.rand(ndata) - 5
    # y = 0.5 * x + 0.5 * np.random.randn(ndata)
    # A = 10. ** np.random.rand(ndata)
    # c = np.random.rand(ndata)
    # return json.dumps([{"_id": i, "x": x[i], "y": y[i], "area": A[i],
    #     "color": c[i]}
    #     for i in range(ndata)])

def read_to_json(project):
    json_file = {}

    with open('/tmp/software_evolution_DQ/'+project+'.txt') as f:
        data = f.read()

    data = data.split('sxNode')
    del data[0]
    # data = iterate_input(data, json_file)
    json_data = json.dumps(data)
    return json_data

def iterate_input(data, json_file):

    for node in data:
        if node.endswith(')'):
            pass
        else:
            json_file[node.rsplit(',', 1)[0]] = iterate_input()
        temp_dict = {}
        # if '[]' in node:

        json_file[node] = temp_dict

def subprocess_cmd(command):
    process = subprocess.Popen(command,stdout=subprocess.PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    return proc_stdout

if __name__ == "__main__":

    port = 8001

    # Open a web browser pointing at the app.
    os.system("open http://localhost:{0}".format(port))

    # Set up the development server on port 8000.
    app.debug = True
    app.run(port=port)
