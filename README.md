# earth-online
## Description
Sample PureQML project. Live stream video from ISS cameras (thanks [HDEV](https://eol.jsc.nasa.gov/ESRS/HDEV/) project) with Earth map.
To show/hide map click screen.
Visit [this link](https://habrahabr.ru/post/326006/) for more details.

## Result
You can check working app [here](https://pureqml.github.io/earth-online/).

## Install
To build the app run commands below:
```
git clone git@github.com:pureqml/earth-online.git
cd earth-online
git submodule init
git submodule update
./qmlcore/build
```
The result will be in `build.web` directory.
