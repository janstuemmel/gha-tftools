# tftools composite action

This action installs the tools [tfenv](https://github.com/tfutils/tfenv) and [tgenv](https://github.com/taosmountain/tgenv). The tools are added to the github actions so that they can be used later in github actions. It also uses both tools to install the latest terrafrom and terragrunt version and configures them as default, so that both can be used in projects that do not rquire a specific version of those tools.

## Inputs

### `tfenv-version`

**Optional** Specify a specific version of tfenv that should be installed.

### `tgenv-version`

**Optional** Specify a specific version of tgenv that should be installed.

## Example usage
```
uses: suddeutsche/tftools@v1
```

or with specific version:

```
uses: suddeutsche/tftools@v1
with:
  tfenv-version: '2.2.2'
```
