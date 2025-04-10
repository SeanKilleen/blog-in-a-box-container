# Blog-in-a-Box Container

A repository that hosts the container for [blog-in-a-box](https://github.com/SeanKilleen/blog-in-a-box) and functions as a devcontainer for blogs operating on GitHub Pages.

We maintain and publish the container separately so that we can reference it in Blog-in-a-Box to start the dev container quickly.

We try to keep it up to date with [the GitHub Pages dependencies](https://pages.github.com/versions), though this is currently a manual process.

## What the Container Includes

* Ruby, at a compatible version with GitHub Pages (based on tags)
* Git, tzdata updates, and the corresponding `bundler` gem at the time of build
* Node at the specified major version, selectable via tag
* The following npm packages globally installed:
  * `cSpell`
  * `markdownlint-cli`
  * `markdownlint-cli2`
* Port 4000 exposed, as this is what Jekyll publishes on.

## Get Involved

We're always up to learn and improve! We'd love your input and suggestions; feel free to create a GitHub issue here and tell us where we can take things next or how we can improve our build & release process.
