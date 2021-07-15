#!/usr/bin/env python3

import os
import sys
from pathlib import Path

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--remove-symlinks", action="store_true", help="Remove all symlinks.")
args = parser.parse_args()


def symlink_dir(entry: os.DirEntry):
    assert entry.is_dir(), f"'{entry.path}' is not a directory!"

    for f in os.scandir(entry):
        link_config(f)

def create_link(entry: os.DirEntry, dotconfig: bool):
    src = entry.path
    if dotconfig:
        dst = os.path.join(DOT_CONFIG, entry.name)
    else:
        dst = os.path.join(HOME, entry.name)

    # If dst is a symlink
    if os.path.islink(dst):

        # Remove symlinks if arg is set
        if args.remove_symlinks:
            print(f"Removing {dst}")
            os.remove(dst)
            return

        # If dst links to src, all is good
        if Path(os.readlink(dst)) == Path(src):
            print(f"{dst} already linked correctly, skipping ...")
            return

    if os.path.exists(dst):

        if os.path.isdir(dst):
            print(f"Destination: {dst} already exists (dir)")
            return
        elif os.path.isfile(dst):
            print(f"Destination: {dst} already exists (file)")
            return
        else:
            raise Exception(f"Destination: {dst} exists but is not a symlink!")



    os.symlink(src, dst, target_is_directory=entry.is_dir())
    print(f"{src} -> {dst}, is_dir={entry.is_dir()}")


def link_config(entry: os.DirEntry):
    if entry.name == ".config":
        for e in os.scandir(entry):
            create_link(e, True)
    else:
        create_link(entry, False)

if __name__ == '__main__':

    # Home path
    HOME = os.getenv("HOME")
    DOT_CONFIG = os.path.join(HOME, ".config")

    CONFIG_DIR = os.path.join(os.getcwd(), "configs")
    for entry in os.scandir(CONFIG_DIR):
        symlink_dir(entry)
