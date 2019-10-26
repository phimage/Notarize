# notarize
[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/)

A tool to notarize your  `.app` files.
Could also get notarization information in different format like JSON.

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
history    Show history
info       Show information
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

### History command

```
$ notarize history --username "me" --password "keychain@dummy"
```

### Info command

```
$ notarize info --uuid a1b2c3d4e5f6 --username "me" --password "keychain@dummy"
```

### Use a reporter in any command

```
$ notarize info --uuid a1b2c3d4e5f6 --username "me" --password "keychain@dummy" --reporter xml
```

```
$ notarize info --uuid a1b2c3d4e5f6 --username "me" --password "keychain@dummy" --reporter json
```
 
## Configuration

You can configure notarize by adding a `.notarize.yml` file in your working directory


| key                  | description                 |
|:---------------------|:--------------------------- |
| `username`           | The username.    |
| `password`           | The password.    |
| `ascProvider`        | The asc provider |
| `reporter`           | How to display information: json, xml |

```yaml
username: "me"
password: "keychain@dummy"
reporter: "json"
```

You can also use this configuration file with --config
```
$ notarize --app Your/App.app --config "path/to/.notarize.yml`"
```

## Dependencies

* [NotarizationProcess](https://github.com/phimage/NotarizationProcess)
* [Commandant](https://github.com/Carthage/Commandant)
* [Yams](https://github.com/jpsim/Yams)

[Show graph online](https://dreampuf.github.io/GraphvizOnline/#digraph%20DependenciesGraph%20%7B%0Anode%20%5Bshape%20%3D%20box%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%5Blabel%3D%22Notarize%5Cn%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%5Blabel%3D%22NotarizationInfo%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%5Blabel%3D%22NotarizationAuditLog%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%5Blabel%3D%22NotarizeProcess%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%5Blabel%3D%22NotarizeProcess%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%5Blabel%3D%22NotarizationInfo%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%5Blabel%3D%22NotarizationAuditLog%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%5Blabel%3D%22Commandant%5Cnhttps%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%5Cn0.17.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%5Blabel%3D%22Commandant%5Cnhttps%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%5Cn0.17.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%5Blabel%3D%22Quick%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%5Cn2.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%5Blabel%3D%22Quick%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%5Cn2.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%5Blabel%3D%22CwlCatchException%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%5Blabel%3D%22CwlCatchException%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%0A%22https%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%22%5Blabel%3D%22Yams%5Cnhttps%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%5Cn2.0.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%22%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%5Blabel%3D%22PathKit%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%5Cn1.0.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%5Blabel%3D%22PathKit%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%5Cn1.0.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%22%5Blabel%3D%22Spectre%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%5Cn0.9.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%22%0A%7D)
