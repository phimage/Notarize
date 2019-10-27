# notarize
[![Build Status][build-shield]][build-url]
[![Swift 5.1][swift-shield]][swift-url]
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
<a href="https://www.patreon.com/phimage">
<img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Become a Patron!" height="20">
</a>
<a href="https://paypal.me/ericphimage">
<img src="https://buymecoffee.intm.org/img/button-paypal-white.png" alt="Buy me a coffee" height="20">
</a>

A tool to notarize your  `.app` files.

Could also get notarization information in different format than `xcrun altool` like JSON.

## What notarize could do for you?

- 📦 Zip the app - using `ditto`
- ⬆️ Upload it to apple service - using `xcrun altool`
- ⏳ Wait for final notarization result - by polling on `xcrun altool`
- 🧷 Staple your app. - using `xcrun stapler`

## Install

### Using sources

```
git clone https://github.com/phimage/Notarize.git
cd Notarize
make install
```
_Xcode must be installed_

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

* [NotarizationProcess](https://github.com/phimage/NotarizeProcess)
* [Commandant](https://github.com/Carthage/Commandant)
* [Yams](https://github.com/jpsim/Yams)

[Show graph online](https://dreampuf.github.io/GraphvizOnline/#digraph%20DependenciesGraph%20%7B%0Anode%20%5Bshape%20%3D%20box%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%5Blabel%3D%22Notarize%5Cn%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%5Blabel%3D%22NotarizationInfo%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%5Blabel%3D%22NotarizationAuditLog%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%5Blabel%3D%22NotarizeProcess%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%5Cnunspecified%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%5Blabel%3D%22NotarizeProcess%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%5Blabel%3D%22NotarizationInfo%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationInfo%22%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%5Blabel%3D%22NotarizationAuditLog%5Cnhttps%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%5Cnunspecified%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizeProcess%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fphimage%2FNotarizationAuditLog%22%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%5Blabel%3D%22Commandant%5Cnhttps%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%5Cn0.17.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%5Blabel%3D%22Commandant%5Cnhttps%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%5Cn0.17.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%5Blabel%3D%22Quick%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%5Cn2.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%5Blabel%3D%22Quick%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%5Cn2.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FQuick.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%5Blabel%3D%22CwlCatchException%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2FCarthage%2FCommandant.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%5Blabel%3D%22Nimble%5Cnhttps%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%5Cn8.0.4%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2FQuick%2FNimble.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%5Blabel%3D%22CwlPreconditionTesting%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%5Blabel%3D%22CwlCatchException%5Cnhttps%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%5Cn1.2.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlPreconditionTesting.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fmattgallagher%2FCwlCatchException.git%22%0A%22https%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%22%5Blabel%3D%22Yams%5Cnhttps%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%5Cn2.0.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fjpsim%2FYams.git%22%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%5Blabel%3D%22PathKit%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%5Cn1.0.0%22%5D%0A%22%2FUsers%2Fphimage%2FNotarizeUI%2FNotarize%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%5Blabel%3D%22PathKit%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%5Cn1.0.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%22%5Blabel%3D%22Spectre%5Cnhttps%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%5Cn0.9.0%22%5D%0A%22https%3A%2F%2Fgithub.com%2Fkylef%2FPathKit.git%22%20-%3E%20%22https%3A%2F%2Fgithub.com%2Fkylef%2FSpectre.git%22%0A%7D)

## Contributing

Fork and make PR

### TODO

- allow to skip some step (like staple, or wait)
- with an option like verbose, show log for each step
- other output format ie. reporter
- better error printing -> formatted by reporter
- maybe save app name and path with notarization uuid to have further information when getting history or info

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/phimage/Notarize.svg?style=flat
[contributors-url]: https://github.com/phimage/Notarize/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/phimage/Notarize.svg?style=flat
[forks-url]: https://github.com/phimage/Notarize/network/members
[stars-shield]: https://img.shields.io/github/stars/phimage/Notarize.svg?style=flat
[stars-url]: https://github.com/phimage/Notarize/stargazers
[issues-shield]: https://img.shields.io/github/issues/phimage/Notarize.svg?style=flat
[issues-url]: https://github.com/phimage/Notarize/issues
[license-shield]: https://img.shields.io/github/license/phimage/Notarize.svg?style=flat
[license-url]: https://github.com/phimage/Notarize/blob/master/LICENSE
[swift-shield]: https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat
[swift-url]: https://developer.apple.com/swift/
[build-shield]: https://travis-ci.org/phimage/Notarize.svg?branch=master
[build-url]: https://travis-ci.org/phimage/Notarize
