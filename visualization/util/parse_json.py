# -*- coding: utf-8 -*-
import json
import ast

c = 'children'

def read_to_json(project):
    with open('/tmp/software_evolution_DQ/'+project+'.json') as f:
        data = f.read()

    json_data = json.loads(data)
    return json.dumps(json_data)

def manipulate_json(json_data):
    data = json.loads(json_data)
    root = data['suffixTree'][0]['children']
    name = str(data['suffixTree'][0]['id'])

    dicts_by_id = build_dict(data['suffixTree'], 'id')

    result_json = fill_children(root[1:-1].split(','),
                                {},
                                dicts_by_id,
                                name)

    result_json[c] = [elem for elem in result_json[c] if c in elem.keys()]
    return json.dumps(result_json)

def fill_children(id_children, result_json, dicts_by_id, name):
    result_json["name"] = name
    result_json[c] = []
    counter = -1

    if len(id_children) == 1:
        # No children
        del result_json[c]
        return result_json
    else:
        # multiple children
        for x in id_children:
            counter += 1
            result_json[c].append(dicts_by_id[x])
            nxt_result_json = result_json[c][counter]
            nxt_result_json['name'] = nxt_result_json['id']
            if nxt_result_json['location'] == "|empty:///|" or nxt_result_json['location'] == "|unknown:///|":
                nxt_result_json['location'] = nxt_result_json['size']
            else:
                nxt_result_json['location'] = nxt_result_json['location'].split('://')[1]

            print nxt_result_json['location']

            recursion = [fill_children(nxt_result_json[c][1:-1].split(','),
                               nxt_result_json,
                               dicts_by_id,
                               str(nxt_result_json['id'])
                               )]
        return result_json

def build_dict(seq, key):
    return dict((d[key], dict(d, index=index)) for (index, d) in enumerate(seq))
