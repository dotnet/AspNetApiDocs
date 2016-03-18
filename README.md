# ASP.NET API Docs

This repo is used to generate the ASP.NET API docs using the [Sphinx AutoAPI](https://github.com/rtfd/sphinx-autoapi) extension.

This repo uses Git submodules to include the various ASP.NET repos. You should clone this repo using a recursive clone (`git clone --recursive https://github.com/aspnet/apidocs`) so that all of the submodules are included.

## Setup

After cloning you need to do the following setup steps:
  1. [Install DNX (64 bit)](http://docs.asp.net/en/latest/getting-started/index.html)
  2. Restore packages for all submodules by running `dnu restore --parallel aspnet`
  3. Install the latest build of [docfx](https://github.com/dotnet/docfx) from the [docfx dev  feed](https://myget.org/gallery/docfx-dev) by running `dnu commands install docfx`
  4. Install [Python](http://python.org)
  5. Install [Sphinx](http://sphinx-doc.org) and the required extensions by running `pip install -r requirements.txt`
  6. TEMPORARY WORKAROUND: Modify the .NET AutoAPI mapper in your `site_packages` folder to comment out the call to docfx:

```python
def load(self, patterns, dirs, ignore=None, **kwargs):
    '''
    Load objects from the filesystem into the ``paths`` dictionary.

    '''
    raise_error = kwargs.get('raise_error', True)
    all_files = set()
    for _file in self.find_files(patterns=patterns, dirs=dirs, ignore=ignore):
        # Iterating for Sphinx output clarify
        all_files.add(_file)
    # if all_files:
    #     try:
    #         command = ['docfx', 'metadata', '--raw', '--force']
    #         command.extend(all_files)
    #         proc = subprocess.Popen(
    #             ' '.join(command),
    #             stdout=subprocess.PIPE,
    #             stderr=subprocess.PIPE,
    #             shell=True,
    #             env=dict((key, os.environ[key])
    #                      for key in ['PATH', 'HOME', 'SYSTEMROOT',
    #                                  'USERPROFILE', 'WINDIR']
    #                      if key in os.environ),
    #         )
    #         _, error_output = proc.communicate()
    #         if error_output:
    #             self.app.warn(error_output)
    #     except (OSError, subprocess.CalledProcessError) as e:
    #         self.app.warn('Error generating metadata: {0}'.format(e))
    #         if raise_error:
    #             raise ExtensionError('Failure in docfx while generating AutoAPI output.')
    # We now have yaml files
    for xdoc_path in self.find_files(patterns=['*.yml'], dirs=['_api_'], ignore=ignore):
        data = self.read_file(path=xdoc_path)
        if data:
            self.paths[xdoc_path] = data
```

To build the ASP.NET API docs:
  1. Run `docfx` to pregenerate the API reference metadata
  2. Run `make` from the `docs` folder to build the .rst files

The generated reStructuredText files will be in the `docs/autoapi` folder. The metadata output from docfx can be found in the `docs/_api_` folder.

You can control which repos and projects you want to generate API docs for by modifying docfx.json.

## Known Issues

- Restore fails for some build dependencies in the Kestrel and MVC repos. The failures can be ignored.
- Running docfx on all of the ASP.NET projects is very memory intensive and requires a 64-bit process or you will get `OutOfMemoryExceptions`.
- The generated *View on GitHub* links are broken (https://github.com/rtfd/sphinx-autoapi/issues/31)
- C# operator overloading not currently supported and results in build warnings
- C# indexers are not currently supported and result in build warnings
- Various issues with handling of generics result in build warnings

