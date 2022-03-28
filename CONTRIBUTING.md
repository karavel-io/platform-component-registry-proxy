# Contribution Guide

## Component

The component is packaged as a [Helm] chart with special metadata added to the [Chart.yaml](chart/Chart.yaml) in the form
of annotations. 

To propose a change to this component, first [open an issue](https://github.com/projectkaravel/platform-component-registry-proxy/issues/new)
where you explain the feature you want to implement. This will help maintainers better evaluate your proposal in light of the 
broader roadmap for the component and advise you on how to move forward with your contribution.

When you are ready to implement your changes, fork the repository and commit your feature to your fork.
Finally [open a pull request](https://github.com/projectkaravel/platform-component-registry-proxy/compare/main) from your fork to the `main`
branch of this repository. A maintainer will review your changes and help you successfully land your contribution.

Please note we have a [code of conduct], please follow it in all your interactions with the project.

Thank you for contributing to this project, and welcome to the Karavel community!

## Documentation

The documentation is built with [mkdocs] and the [mkdocs-material] theme.  
To quickly preview changes made to the files in the [docs](./docs) folder, a Docker-based script
is provided at [hacks/mkdocs](./hacks/mkdocs). Simply running the script will start the development
server at [http://localhost:8000](http://localhost:8000).

[Helm]: https://helm.sh
[mkdocs]: https://mkdocs.org
[mkdocs-material]: https://squidfunk.github.io/mkdocs-material
[code of conduct]: https://github.com/projectkaravel/community/blob/main/CODE_OF_CONDUCT.md
