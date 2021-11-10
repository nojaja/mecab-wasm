mecab-wasm
----------

[Mecab](https://taku910.github.io/mecab/) is a morphological analyzer for Japanese.

This repository builds Mecab with Emscripten, so it can be used in a browser.

See [examples/](examples/) for usage examples.


# develop
1. install [emscripten](https://emscripten.org/docs/getting_started/downloads.html)
```
# Get the emsdk repo
git clone https://github.com/emscripten-core/emsdk.git

# Enter that directory
cd emsdk

# Download and install the latest SDK tools.
./emsdk install latest

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
./emsdk activate latest

# Activate PATH and other environment variables in the current terminal
source ./emsdk_env.sh
```

2. make
```
make
```

