#!/usr/bin/env python
import argparse
import json
import os

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

    if args.list:
        print(json.dumps(hostname_to_inventory(hostnames)))
        return

    if args.host:
        print(json.dumps({}))
        return

    # --limit オプションの引数を fzf などで選択するために用いる
    # questionary や pick の採用を検討したが、いずれもコマンド置換・パイプとの相性が悪かった。
    print("\n".join(hostnames))


if __name__ == "__main__":
    main()
