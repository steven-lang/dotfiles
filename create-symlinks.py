#!/usr/bin/env python3

import os
import sys
from pathlib import Path
import logging

import argparse




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
        if ARGS.remove_symlinks:
            LOGGER.info(f"Removing {dst}")
            os.remove(dst)
            return

        # If dst links to src, all is good
        if Path(os.readlink(dst)) == Path(src):
            LOGGER.debug(f"{dst} already linked correctly, skipping ...")
            return

    if os.path.exists(dst):

        if os.path.isdir(dst):
            LOGGER.info(f"Destination: {dst} already exists (dir)")
            return
        elif os.path.isfile(dst):
            LOGGER.info(f"Destination: {dst} already exists (file)")
            return
        else:
            raise Exception(f"Destination: {dst} exists but is not a symlink!")

    # No case catched -> create symlink
    os.symlink(src, dst, target_is_directory=entry.is_dir())
    LOGGER.info(f"{src} -> {dst}")


def link_config(entry: os.DirEntry):
    if entry.name == ".config":
        for e in os.scandir(entry):
            create_link(e, True)
    else:
        create_link(entry, False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--remove-symlinks", "-r", action="store_true", help="Remove all symlinks."
    )
    parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output.")
    ARGS = parser.parse_args()


    # Setup logging
    if ARGS.verbose:
        log_level = logging.DEBUG
    else:
        log_level = logging.INFO

    logging.basicConfig(encoding='utf-8', level=log_level)
    LOGGER = logging.getLogger(__name__)

    # Home path
    HOME = os.getenv("HOME")
    DOT_CONFIG = os.path.join(HOME, ".config")
    CONFIG_DIR = os.path.join(os.getcwd(), "configs")

    # Scan all dirs in "./configs/"
    for entry in os.scandir(CONFIG_DIR):
        symlink_dir(entry)
