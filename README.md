# Dantin's dotfile

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

The dotfile is a personal project which is aimed to simpilify the setup process of a development environemnt.

This repository contains:

1. The scripts used in everyday life.
2. Tmux configuration file.
3. AutoHotkey script used on Windows box.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Related Efforts](#related-efforts)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

I found it is boring and time consuming while setting up development environment on different machines, e.g.
MacOS, CentOS, etc.

Inspired by the __DRY__ principle, I create this project as a scaffold to accelerate the process.

> DRY: Don't Repeat Yourself.


## Install

__Warning:__ If you want to give these dotfiles a try, you should first fork this repository, review the code, and
remove things you don't want or need. Don't blindly use my settings unless you know what that entails. Use at your
own risk!

### Using Git and bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Documents/code/dotfile`.) The bootstrapper
script will pull in the latest version and copy the files to your home folder.

    git clone https://github.com/dantin/dotfile.git && cd dotfile && source bootstrap.sh

To update, `cd` into your local `dotfile` repository and then:

    source bootstrap.sh

## Usage

This is only a documentation page. You can find out more on [specification](SPEC.md).

## Related Efforts

- [environment-setup](https://github.com/dantin/environment-setup) - An Ansible playbooks that setup Linux box.
- [vim-config](https://github.com/dantin/vim-config) - A personal configuration of Vim.

## Maintainers

[@dantin](https://github.com/dantin)

## Contributing

Suggestions and improvements welcome!

Free free to [Open an issue](https://github.com/dantin/dotfile/issues/new) or submit PRs.

## License

[BSD 3 Clause](LICENSE) © David Ding
