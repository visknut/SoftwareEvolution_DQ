import json
import flask
import numpy as np
import subprocess
import os
import ast

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
    json_dict = {}

    with open('/tmp/software_evolution_DQ/'+project+'.txt') as f:
        data = f.read()

    data = data.replace('[]', '": ""')
    data = data.replace('""),', '"","')
    # data = data.replace('-1],', '"link":')
    data = data.replace('[', '":{"').replace(']', '"},"')
    data = '{"' + data + '"}'

    # data = data.split('sxNode')
    # del data[0]



    # counter = 0
    # test = iterate_input(data, json_dict, counter)
    print data
    json_data = json.loads(data)

    return json.dumps(json_data)

def iterate_input(data, json_dict, counter):
    json_file[node.rsplit(',', 1)[0]] = data[counter:]
    for node in data:
        counter += 1

        if "[]" in node:
            json_dict[node] = ""
        else:
            json_dict[node.rsplit(',', 1)[0]] = iterate_input(data[counter:],
                                                              json_dict)
        return json_dict

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
