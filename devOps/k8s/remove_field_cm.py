#!/usr/local/bin/python3
import ruamel.yaml


def remove_common(data):
    kvs = data["data"]

#TODO: fill here
    blacklist = []

    for to_remove in blacklist:
        if to_remove in kvs:
            del kvs[to_remove]

    return data


def rewrite(data):
    return remove_common(data)


def read_and_write(in_path, out_path):
    to_dump = []
    with open(in_path, 'r') as in_stream:
        try:
            for data in ruamel.yaml.round_trip_load_all(
                    in_stream, preserve_quotes=True):
                to_dump.append(rewrite(data))
        except ruamel.yaml.YAMLError as exc:
            print(exc)

    with open(out_path, 'w') as out_stream:
        ruamel.yaml.dump_all(
            to_dump, out_stream, Dumper=ruamel.yaml.RoundTripDumper)


#TODO: fill here
IN_DIR = ""
OUT_DIR = ""

# TODO: get list
# ls *.yaml | awk '{ print "\""$1"\","}'
FILES = [
]

#file = "paylite-acquiring.yaml"
for file in FILES:
    print("reading " + file)
    read_and_write(IN_DIR + file, OUT_DIR + file)
