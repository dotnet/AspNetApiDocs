# ASP.NET API Docs

This repo is used to generate the ASP.NET API docs using the [Sphinx AutoAPI](https://gitub.com/rtfd/sphinx-autoapi) extension.

This repo uses Git submodules to include the various ASP.NET repos. You should clone this repo using a recursive clone (`git clone --recursive https://github.com/aspnet/apidocs`) so that all of the submodules are included.

## Setup

After cloning you need to do the following setup steps:
1. [Install DNX](http://docs.asp.net/en/latest/getting-started/index.html)
2. Restore packages for all submodules by running `dnu restore --parallel aspnet`
3. Install the latest build of [docfx](https://github.com/dotnet/docfx) from the [docfx dev feed](https://myget.org/gallery/docfx-dev) by running `dnu commands install docfx`
4. Install [Python](http://python.org)
5. Install [Sphinx](http://sphinx-doc.org) and the required extensions by running `pip install -r requirements.txt`

To build the ASP.NET API docs:
1. Run `make` from the `docs` folder

The generated reStructuredText files will be in the `docs/autoapi` folder. The metadata output from docfx can be found in the `docs/_api_` folder.

You can control which repos and projects you want to generate API docs for by modifying docfx.json.

## Known Issus

- Restore fails for some build dependencies in the Kestrel and MVC repos. The failures can be ignored
- The generated *View on GitHub* links are broken (https://github.com/rtfd/sphinx-autoapi/issues/31)
- C# operator overloading not currently supported and results in build warnings
- C# indexers are not currently supported and result in build warnings
- Various issues with handling of generics result in build warnings
