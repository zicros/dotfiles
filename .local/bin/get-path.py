#!/usr/bin/python3
import argparse
import logging
import os
import sys
import tomllib
import re

log = logging.getLogger(__name__)

def configure_logger():
    log.setLevel(logging.INFO)

    stdout_handler = logging.StreamHandler(sys.stdout)
    formatter = logging.Formatter('%(message)s')
    stdout_handler.setFormatter(formatter)

    log.addHandler(stdout_handler)

def create_arg_parser(path_names:list[str]):
    parser = argparse.ArgumentParser(description='Wrapper around az cli tool')
    parser.add_argument('--verbose', action='store_true')
    parser.add_argument('path', choices=path_names)

    return parser

class ErrorException(Exception):
    def __init__(self):
        self.message = "ERROR"
        super().__init__(self.message)

def replace_with_vars(original_string:str, vars:dict):
    tmp_string = original_string
    while True:
        start = tmp_string.find('{')
        if start == -1:
            # No more variables
            break
        end = tmp_string.find('}', start)
        if end == -1:
            log.error("Failed to find ending bracket")
            raise ErrorException()

        variable = tmp_string[start:end + 1]
        variable_name = variable[1:-1]
        if variable_name in vars:
            new_value = vars[variable_name]
        else:
            log.error(f"Failed to find variable {variable_name}")
            raise ErrorException()

        tmp_string = tmp_string.replace(variable, new_value)

    # Resolve any environment variables after resolving all variables.
    return os.path.expandvars(tmp_string)


if __name__ == "__main__":
    configure_logger()

    with open(os.path.expandvars('$HOME/.config/rz/config.toml'), 'rb') as config_file:
        configuration = tomllib.load(config_file)

    parser = create_arg_parser(path_names=(list(configuration['paths'].keys())))
    args = parser.parse_args()

    if args.verbose:
        log.setLevel(logging.DEBUG)

    original_path = configuration['paths'][args.path]
    resolved_path = replace_with_vars(original_string=original_path, vars=configuration['paths'])

    log.info(resolved_path)
