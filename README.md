# Cocoapods plugin to list dependencies with metadata

The cocoapods-dependencies-list enumerates dependencies from the current directory's `Podfile` and `Podfile.lock`, outputting metadata for all dependencies to the console.

This plugin was built primarily to support enumerating dependencies for [github/licensed](https://github.com/github/licensed).  Dependencies are output in JSON format to make parsing and reading data easier for non-human callers.

Dependencies are output as a JSON map of Podfile targets to an array of dependencies for that target.

## Options

1. `--targets=<comma delimited list of Podfile targets>`'
   - Default: none
   - Description: The `targets` option is used to filter enumerated dependencies to only the specified targets.
1. `--fields=<comma delimited list of specification fields>`
   - Default: `"name,version,summary,homepage,license"`
   - Description: The `fields` option specifies which specification fields should be included in the JSON output.
1. `--include-path`, `--no-include-path`
   - Default: `--no-include-path`
   - Description: Whether to include the path to the dependency in the installation sandbox in the JSON output.

## Example

```bash
➜  cocoapods-dependencies-list ✗ (cd test/fixtures && bundle exec pod dependencies | jq)
{
  "Pods": [],
  "Pods-ios": [
    {
      "name": "Alamofire",
      "version": "5.4.3",
      "summary": "Elegant HTTP Networking in Swift",
      "homepage": "https://github.com/Alamofire/Alamofire",
      "license": {
        "type": "MIT"
      }
    },
    {
      "name": "Chatto",
      "version": "4.1.0",
      "summary": "Chat framework in Swift",
      "homepage": "https://github.com/badoo/Chatto",
      "license": {
        "type": "MIT"
      }
    },
    ...
  ],
  "Pods-iosTests": [
    {
      "name": "lottie-ios",
      "version": "3.3.0",
      "summary": "A library to render native animations from bodymovin json",
      "homepage": "https://github.com/airbnb/lottie-ios",
      "license": {
        "type": "Apache",
        "file": "LICENSE"
      }
    }
  ]
}
```

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
