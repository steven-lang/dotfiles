#!/usr/bin/env python3

import os
import argparse
import arxiv


def url_to_id(url: str) -> str:
    """
    Parse the given URL of the form `https://arxiv.org/abs/1907.13625` to the id `1907.13625`.

    Args:
        url: Input arxiv URL.

    Returns:
        str: ArXiv article ID.
    """
    # Strip filetype
    if url.endswith(".pdf"):
        url = url[:-4]

    return url.split("/")[-1]


def check_out_dir(directory: str):
    """Check if the output directory exists. If not, ask the user to mkdir."""
    if not os.path.exists(directory):
        print(f"Directory {directory} does not exist. Create? [y/n] ", end="")
        ans = input().lower().strip()
        if ans == "y":
            os.makedirs(directory)
        elif ans == "n":
            print("Exiting now.")
            exit(1)
        else:
            print("Invalid input. Exiting now.")
            exit(1)


if __name__ == "__main__":
    # Parse arguments
    parser = argparse.ArgumentParser(description="ArXiv downloader.")
    parser.add_argument("--url", "-u", type=str, help="ArXiv article URL.")
    parser.add_argument(
        "--directory", "-d", default="./", type=str, help="Output directory."
    )
    parser.add_argument(
        "--source-tar",
        "-s",
        default=False,
        action="store_true",
        help="Whether to download the source tar file.",
    )
    args = parser.parse_args()

    # TODO: add checks for valid urls
    check_out_dir(args.directory)

    # Download
    article_id = url_to_id(args.url)
    result = arxiv.query(id_list=[article_id])
    print(f'Starting download of article: "{result[0].title}" ({article_id})')
    path = arxiv.download(
        obj=result[0], dirpath=args.directory, prefer_source_tarfile=args.source_tar
    )

    print(f"Download finished! Result saved at:\n{path}")
