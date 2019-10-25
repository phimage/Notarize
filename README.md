# notarize
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/)

A tool to notarize your  `.app` files.

## Install

### Using sources

```
git clone https://github.com/phimage/Notarize.git
cd Notarize
make install
```

## Usage

You can see all description by `notarize help`

```
$ notarize help
Available commands:

help       Display general or command-specific help
notarize   Notarize (default command)
version    Display the current version of notarize
```

### Notarize command

```
$ notarize --app Your/App.app --username "me" --password "keychain@dummy"
```

#### team id

```
$ notarize --app Your/App.app --username "me" --password "keychain@dummy" --ascProvider "MYTEAMID"
```
 
## Configuration

You can configure IBGraph by adding a `.notarize.yml` file in your working directory


| key                  | description                 |
|:---------------------|:--------------------------- |
| `username`           | The username.    |
| `password`           | The password.    |
| `ascProvider`     | The asc provider |

```yaml
username: "me"
password: "keychain@dummy"
```

You can also use this configuration file with --config
```
$ notarize --app Your/App.app --config "path/to/.notarize.yml`"
```
