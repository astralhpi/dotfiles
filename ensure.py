#!/usr/bin/env python

import shutil
import sys
import os
import subprocess


def dir(path):
    if not os.path.isdir(path):
        print(f"Creating directory {path}")
        os.makedirs(path)


def link(path, link):
    link = os.path.realpath(link)

    if os.path.exists(path) and not os.path.islink(path):
        print(f"Remove {path} because it is not a link")
        if os.path.isfile(path):
            os.remove(path)
        else:
            shutil.rmtree(path)

    elif os.path.islink(path) and os.readlink(path) != link:
        print(f"Remove link {path} because it points to {os.readlink(path)}")
        os.unlink(path)

    if not os.path.islink(path):
        print(f"Creating link {path} -> {link}")
        os.symlink(link, path)


def copy(path, source):
    if not os.path.isfile(path):
        print(f"Creating copy {path} -> {source}")
        shutil.copyfile(source, path)


def clone(path, repo, branch=None):
    need_update_submodules = False

    if os.path.isdir(path):
        os.chdir(path)

        cur_repo = (
            subprocess.check_output(["git", "remote", "get-url", "origin"])
            .strip()
            .decode("utf-8")
        )
        if cur_repo != repo:
            print(f"Change remote origin to {repo} because it was {cur_repo}")
            subprocess.check_call(["git", "remote", "set-url", "origin", repo])
            subprocess.check_call(["git", "pull"])
            need_update_submodules = True
    else:
        print(f"Cloning {repo} to {path}")
        subprocess.check_call(["git", "clone", "--depth", "1", repo, path])
        need_update_submodules = True
        os.chdir(path)

    if (
        branch is not None
        and subprocess.check_output(
            ["git", "rev-parse", "--abbrev-ref", "HEAD"]
        ).strip()
        != branch
    ):
        print(f"Checkout branch {branch}")
        subprocess.check_call(["git", "checkout", branch])

    if need_update_submodules:
        print("Update submodules")
        subprocess.check_call(["git", "submodule", "update", "--init", "--recursive"])


def file(path, command):
    if not os.path.isfile(path):
        print(f"Creating file {path}")
        subprocess.check_call(command, shell=True)


def install(cmd, *install_cmds):
    try:
        subprocess.check_call(f"which {cmd}", shell=True)
    except subprocess.CalledProcessError:
        print(f"Install {cmd}")
        for install_cmd in install_cmds:
            print(f"Run {install_cmd}")
            subprocess.check_call(install_cmd, shell=True)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py function [args...]")
        sys.exit(1)

    function_name = sys.argv[1]
    args = sys.argv[2:]

    func = globals().get(function_name)
    if func is not None:
        func(*args)
    else:
        print(f"Unknown function: {function_name}")
        sys.exit(1)
