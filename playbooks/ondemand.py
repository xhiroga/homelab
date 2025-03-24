#!/usr/bin/env python
import argparse
import json
import os

import questionary
from sshconf import read_ssh_config


def parse(ssh_config_path: str) -> list[str]:
    """
    敢えてファイルパスを受け取らないのは単体テストのため。
    ssh接続情報は ssh_config に記載されている前提だから、ansible_user や ansible_ssh_private_key_file も返さない。
    簡単のため _meta は返さない。
    """
    config = read_ssh_config(ssh_config_path)
    hostnames = config.hosts()

    if "*" in hostnames:
        hostnames.remove("*")

    return list(hostnames)


def hostname_to_inventory(hostnames: list[str]):
    return {"all": {"hosts": hostnames}}


def limited_hosts(hostnames: list[str]):
    """
    Ansible の --limit オプションの引数を動的に選択するためのユーティリティ。
    """
    selected_hosts: list[str] = questionary.checkbox(
        "Select hosts:", choices=hostnames
    ).ask()

    return ",".join(selected_hosts)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "ssh_config",
        nargs="?",
        default="~/.ssh/config",
        help="Path to SSH config file (default: ~/.ssh/config)",
    )
    parser.add_argument("--list", action="store_true", help="for ansible")
    parser.add_argument("--host", help="for ansible")
    args = parser.parse_args()

    expanded = os.path.expanduser(args.ssh_config)
    hostnames = parse(expanded)
    inventory = hostname_to_inventory(hostnames)

    if args.list:
        print(json.dumps(inventory))
        return

    if args.host:
        print(json.dumps({}))
        return

    print(limited_hosts(hostnames))


if __name__ == "__main__":
    main()
