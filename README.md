# PyInstaller-Action-Linux

Github Action for building executables with PyInstaller for running on Linux

To build your application, you need to specify where your source code is via the `path` argument, this defaults to `src`.

The source code directory should have your `.spec` file that PyInstaller generates. If you don't have one, you'll need to run PyInstaller once locally to generate it. Also if you have another program `.spec` file you can set specific pyinstaller `.spec` file by `spec: <YOUR_SPEC_FILE_NAME>`

If the `src` folder has a `requirements.txt` file, the packages will be installed into the environment before PyInstaller runs.

If you wish to specify a package mirror, this is possibly via the `pypi_url` and/or the `pypi_index_url`, these defaults are:

- `pypi_url` = `https://pypi.python.org/`
- `pypi_index_url` = `https://pypi.python.org/simple`

If the application requires `Tkinter`, ensure to set the `tkinter` argument to true (this is under the `with` similar to how path is defined).

> If you are using the default Python `gitignore` file, ensure to remove `.spec`

## Example usage

Include this in your `.github/workflows/main.yaml`:

```yaml
- name: PyInstaller Linux
  uses: JackMcKew/pyinstaller-action-linux@main
    with:
      path: src
```

## Full Example

Here is an entire workflow for:

- Packaging an application with PyInstaller
- Uploading the packaged executable as an artifact

``` yaml

name: Package Application with Pyinstaller

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Package Application
      uses: JackMcKew/pyinstaller-action-linux@main
      with:
        path: src

    - uses: actions/upload-artifact@v2
      with:
        name: name-of-artifact
        path: src/dist/linux
```

## Sources

A big thank you to all the contributors over at <https://github.com/cdrx/docker-pyinstaller>, this action is just a modified version of their docker container, thank you!
