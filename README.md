# QML Creative Controls

Controls useful in a creative coding context.

## Building

    qmake
    make -j

## Using

Put the `CreativeControls` folder in your Qt installation, so that it looks like:

```
    ~/Qt/5.8/gcc_64/qml/CreativeControls/libqml-creative-controls.so
                                        /Foo.qml
                                      # /etc...
```

If you do not wish to pollute your path, you will have to add the parent folder (the git repostiory)
to your QML2_IMPORT_PATH, either through qmake, an environment variable, code...

## Notes

This library can be useful in conjunction with [libossia](https://github.com/OSSIA/libossia).
See [OssiaExample.qml](examples/OssiaExample.qml).

## Inspiration

* [Lemur](https://liine.net)

* [HOALibrary](https://cycling74.com/toolbox/hoalibrary-v2/)

* [Musinekit](http://www.sensomusic.org/musinekit/en)

* [TouchOSC](https://hexler.net/software/touchosc)

* [Audiomulch](http://www.audiomulch.com/)

* [ofxDatGui](https://github.com/braitsch/ofxDatGui)

* [Luminosus](https://www.luminosus.org)

* [oui.js](https://github.com/wearekuva/oui)

* [dat.gui](http://workshop.chromeexperiments.com/examples/gui)

* [p5.gui](https://github.com/bitcraftlab/p5.gui)

* [controlp5](https://github.com/sojamo/controlp5)

* [Dear ImGui](https://github.com/ocornut/imgui)

* [nanogui](https://github.com/wjakob/nanogui)

* [ofxAVUI](https://github.com/AVUIs/ofxAVUI)

* [ofxCvGui](https://github.com/elliotwoods/ofxCvGui)

* [quickcollider](https://github.com/jleben/quickcollider)

* [QtQuickVcp](https://github.com/qtquickvcp/QtQuickVcp)

* [FlatUI](https://github.com/obeezzy/FlatUI)

* [spatium](https://vimeo.com/52321647)

* [qml-color-picker](https://github.com/astorije/qml-color-picker)


