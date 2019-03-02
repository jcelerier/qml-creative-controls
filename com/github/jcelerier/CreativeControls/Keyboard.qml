import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A piano keyboard.
// Properties:
// * pressedKeys:
//      the keys that are currently being played.
//      The objects in pressedKeys have the format: { key: v1, vel: v2 }
//      where v1, v2 are between [0, 127]
// * firstKey / lastKey : limits of the keyboard
Item {
    width: 200
    height: 100

    property var styles: DarkStyle
    onStylesChanged: canvas.requestPaint()
    property real xScale: Math.max(width / (34 * keyWidth), 1.0)
    property real yScale: Math.max(height / whiteHeight, 1.0)

    property int firstKey: 17
    property int lastKey: 75

    property real keyWidth: 20
    property real whiteHeight: 100

    property real blackHeight: 55
    property real blackWidth: 13

    property var whitePos: []
    property var blackPos: []

    property var pressedKeys: []

    onFirstKeyChanged: recomputePos()
    onLastKeyChanged: recomputePos()
    onXScaleChanged: recomputePos()
    onYScaleChanged: recomputePos()
    Component.onCompleted: recomputePos()

    // Compute the graphical position of every piano key
    function recomputePos() {
        whitePos = []
        blackPos = []
        var cur_x = 0
        for (var it = firstKey; it < lastKey; ++it) {
            if (!isBlackKey(it)) {
                whitePos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x, 0, xScale * keyWidth,
                                                  yScale * whiteHeight)
                              })
                cur_x += xScale * keyWidth
            }
        }

        cur_x = 0

        for (var it = firstKey; it < lastKey; ++it) {
            switch (it % 12) {

                /*  case 0: cur_x += xScale * keyWidth / 2; break;
            case 1: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight)});
                    cur_x += xScale * keyWidth / 2; break;
            case 2: cur_x += xScale * keyWidth / 2; break;
            case 3: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight) });
                    cur_x += xScale * keyWidth / 2; break;
            case 4: cur_x += xScale * keyWidth ; break;
            case 5: cur_x += xScale * keyWidth / 2; break;
            case 6: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight) });
                    cur_x += xScale * keyWidth / 2; break;
            case 7: cur_x += xScale * keyWidth / 2; break;
            case 8: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight) });
                    cur_x += xScale * keyWidth / 2; break;
            case 9: cur_x += xScale * blackWidth / 2; break;
            case 10: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight) });
                     cur_x += xScale * keyWidth / 2; break;
            case 11: cur_x += xScale * keyWidth; break;*/
            case 0:
                cur_x += xScale * (keyWidth)
                break
            case 1:
                blackPos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x - blackWidth / 2, 0,
                                                  xScale * blackWidth,
                                                  yScale * blackHeight)
                              })
                break
            case 2:
                cur_x += xScale * (keyWidth)
                break
            case 3:
                blackPos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x - blackWidth / 2, 0,
                                                  xScale * blackWidth,
                                                  yScale * blackHeight)
                              })
                break
            case 4:
                cur_x += xScale * (keyWidth)
                break
            case 5:
                cur_x += xScale * (keyWidth)
                break
            case 6:
                blackPos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x - blackWidth / 2, 0,
                                                  xScale * blackWidth,
                                                  yScale * blackHeight)
                              })
                break
            case 7:
                cur_x += xScale * keyWidth
                break
            case 8:
                blackPos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x - blackWidth / 2, 0,
                                                  xScale * blackWidth,
                                                  yScale * blackHeight)
                              })
                break
            case 9:
                cur_x += xScale * keyWidth
                break
            case 10:
                blackPos.push({
                                  "key": it,
                                  "rect": Qt.rect(cur_x - blackWidth / 2, 0,
                                                  xScale * blackWidth,
                                                  yScale * blackHeight)
                              })
                break
            case 11:
                cur_x += xScale * keyWidth
                break
            default:
                break
            }
        }
    }

    function isBlackKey(key) {
        var mod = key % 12
        return (mod === 1) || (mod === 3) || (mod === 6) || (mod === 8)
                || (mod === 10)
    }

    function drawBlackKey(key, ctx, cur_x) {
        ctx.fillRect(cur_x, 0, xScale * blackWidth, yScale * blackHeight)
        ctx.rect(cur_x, 0, xScale * blackWidth, yScale * blackHeight)
    }

    // Check if a piano key is pressed
    function isPressed(key) {
        return pressedKeys.length > 0 && pressedKeys[0].key === key
    }

    // Check if a position is in a given rectangle
    function posInRect(theRect, mouseX, mouseY) {
        return mouseX >= theRect.x && mouseX <= theRect.x + theRect.width
                && mouseY >= theRect.y && mouseY <= theRect.y + theRect.height
    }

    // Get the index of a piano key from a position
    function keyFromPos(mouseX, mouseY) {
        for (var it = 0; it < blackPos.length; ++it) {
            if (posInRect(blackPos[it].rect, mouseX, mouseY)) {
                return {
                    "key": blackPos[it].key,
                    "vel": Utils.rescale(mouseY, 0,
                                         blackHeight * yScale, 0, 127)
                }
            }
        }

        for (var it = 0; it < whitePos.length; ++it) {
            if (posInRect(whitePos[it].rect, mouseX, mouseY)) {
                return {
                    "key": whitePos[it].key,
                    "vel": Utils.rescale(mouseY, 0,
                                         whiteHeight * yScale, 0, 127)
                }
            }
        }
    }

    // Compare two arrays to check if the same keys are pressed in it
    function sameKeys(a1, a2) {
        return a1.length === a2.length && a1.every(function (v, i) {
            return v.key === a2[i].key
        })
    }

    function setPressed(key) {
        if (key !== undefined) {
            var newKeys = [key]
            if (!sameKeys(newKeys, pressedKeys)) {
                pressedKeys = newKeys
            }
        } else {
            pressedKeys = []
        }

        canvas.requestPaint()
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            var cur_x = 0
            var N = lastKey - firstKey

            ctx.beginPath()
            ctx.strokeStyle = styles.keyBorder
            ctx.fillStyle = styles.whiteKeyColor
            ctx.lineWidth = 1

            for (var it = firstKey; it < lastKey; ++it) {
                if (!isBlackKey(it)) {
                    if (isPressed(it)) {
                        ctx.fillStyle = styles.whiteKeyDetail
                    }

                    ctx.fillRect(cur_x, 0, xScale * keyWidth, yScale * whiteHeight)
                    ctx.rect(cur_x, 0, xScale * keyWidth, yScale * whiteHeight)
                    cur_x += xScale * keyWidth

                    if (isPressed(it)) {
                        ctx.fillStyle = styles.whiteKeyColor
                    }
                }
            }

            ctx.stroke()
            ctx.closePath()

            ctx.beginPath()
            ctx.fillStyle = styles.blackKeyColor
            ctx.strokeStyle = styles.keyBorder
            cur_x = 0

            for (var it = firstKey; it < lastKey; ++it) {

                if (isPressed(it)) {
                    ctx.fillStyle = styles.blackKeyDetail
                }

                switch (it % 12) {
                case 0:
                    cur_x += xScale * (keyWidth)
                    break
                case 1:
                    drawBlackKey(it, ctx, cur_x - blackWidth / 2)
                    break
                case 2:
                    cur_x += xScale * (keyWidth)
                    break
                case 3:
                    drawBlackKey(it, ctx, cur_x - blackWidth / 2)
                    break
                case 4:
                    cur_x += xScale * (keyWidth)
                    break
                case 5:
                    cur_x += xScale * (keyWidth)
                    break
                case 6:
                    drawBlackKey(it, ctx, cur_x - blackWidth / 2)
                    break
                case 7:
                    cur_x += xScale * keyWidth
                    break
                case 8:
                    drawBlackKey(it, ctx, cur_x - blackWidth / 2)
                    break
                case 9:
                    cur_x += xScale * keyWidth
                    break
                case 10:
                    drawBlackKey(it, ctx, cur_x - blackWidth / 2)
                    break
                case 11:
                    cur_x += xScale * keyWidth
                    break
                default:
                    break
                }

                if (isPressed(it)) {
                    ctx.fillStyle = styles.blackKeyColor
                }
            }
            ctx.stroke()
            ctx.closePath()
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            var key = keyFromPos(mouseX, mouseY)
            if (key !== undefined)
                pressedKeys = [key]
            else
                pressedKeys = []
            canvas.requestPaint()
        }

        onPositionChanged: {
            var key = keyFromPos(mouseX, mouseY)
            if (key !== undefined) {
                var newKeys = [key]
                if (!sameKeys(newKeys, pressedKeys)) {
                    pressedKeys = newKeys
                }
            } else {
                pressedKeys = []
            }

            canvas.requestPaint()
        }

        onReleased: {
            pressedKeys = []
            canvas.requestPaint()
        }
    }
}
