# First FPS

Metroidvania like, where guns are arms because in French arm = weapon, haha!

Use different weapons to open doors, you can also jump! Amazing!

## Create release
Use [Godot](https://godotengine.org/) editor to export all in release mode.

### HTML5
Download [Python](https://www.python.org/) and [ghp-import](https://pypi.org/project/ghp-import/) via pip:

```
$ pip install ghp-import
```

Deploy in Github page:

```
$ ghp-import -p -m "Update html release" -b gh-page export/html5
```

### Windows, GNU / Linux, Mac
Create git tag and upload compressed files in https://github.com/tyvonnou/ergo-fps/releases.  
To create archive use `release.sh` script.

## TODO

- [x] Ground
- [x] Arm and shoot concept
- [ ] Add new arms
- [x] Add platforms
- [x] Add Walls
- [x] Add doors
- [ ] Add end screen

## Credits

This game use:

* Beautiful textures from [CC0 Textures](https://cc0textures.com/).
* [Ubuntu Font](https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip)

:wrench: with :two_hearts: by:
- [YVONNOU Theo](https://tyvonnou.fr/)
- [PENAUD Loïc](https://lpenaud.github.io/)
