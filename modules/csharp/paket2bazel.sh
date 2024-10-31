#!/usr/bin/env bash

bazel run @rules_dotnet//tools/paket2bazel -- --dependencies-file "$(pwd)/paket.dependencies" --output-folder "$(pwd)/paket/"
