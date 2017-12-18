import json

def read_to_json(project):
    with open('/tmp/software_evolution_DQ/'+project+'.json') as f:
        data = f.read()

    json_data = json.loads(data)
    return json.dumps(json_data)
