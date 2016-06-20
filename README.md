# ASP.NET API Docs

This repo is used to generate the ASP.NET API docs using the [Sphinx AutoAPI](https://github.com/rtfd/sphinx-autoapi) extension.

This repo uses Git submodules to include the various ASP.NET repos. You should clone this repo using a recursive clone (`git clone --recursive https://github.com/aspnet/apidocs`) so that all of the submodules are included.

## Setup

After cloning you need to do the following setup steps:
  1. Install [.NET Core](https://microsoft.com/net)
  2. Restore packages for all submodules by running `dotnet restore`
  3. Install the .NET Core compatible version of [docfx](https://github.com/dotnet/docfx/releases/tag/1.10.0-alpha) and put it on your path
  4. Install [Python](http://python.org)
  5. Install [Sphinx](http://sphinx-doc.org) and the required extensions by running `pip install -r requirements.txt`
  6. Run `make html` from the `docs` folder to build the .rst files

The generated reStructuredText files will be in the `docs/autoapi` folder. The metadata output from docfx can be found in the `docs/_api_` folder.

You can control which repos and projects you want to generate API docs for by modifying docfx.json.

## Known Issues

- Running docfx on all of the ASP.NET projects is very memory intensive and requires a 64-bit process or you will get `OutOfMemoryExceptions`.
- The generated *View on GitHub* links are broken (https://github.com/rtfd/sphinx-autoapi/issues/31)
- C# operator overloading not currently supported and results in build warnings
- C# indexers are not currently supported and result in build warnings

