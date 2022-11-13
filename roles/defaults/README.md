defaults
=========

Configuration for user defaults.

Debug
---

```shell
make --directory ./molecule/docker-image
molecule test
```

Requirements
------------

`defaults` is required.

Role Variables
--------------

See [defaults](./defaults/main.yml).

Note
---

By default, plist files are stored as binary format. This repo commit them as XML format to edit easily.

References and Inspirations
---

- [archlinux - Window Maker](https://wiki.archlinux.jp/index.php/Window_Maker) - Use GNUstep inside.
 - https://macos-defaults.com/dock/orientation.html#set-to-right
 - https://github.com/mathiasbynens/dotfiles/blob/master/.macos
 - https://github.com/hedlund/dotinit/blob/9262d38c61ddf5f852615919030e15f526f2c2f7/mac/setup-macos.sh

