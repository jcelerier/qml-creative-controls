import QtQuick 2.6
import CreativeControls 1.0

// A piano keyboard.
Item
{
    anchors.fill : parent
    property real xScale : Math.max(width / (34 * keyWidth),1.0)
    property real yScale : Math.max(height / whiteHeight,1.0)

    property int firstKey: 17
    property int lastKey: 75

    property real keyWidth : 20
    property real whiteHeight : 100

    property real blackHeight : 55;
    property real blackWidth : 20;

    property var whitePos: []
    property var blackPos: []

    property var pressedKeys : [ ]

    function recomputePos()
    {
        whitePos = [];
        blackPos = [];
        var cur_x = 0;
        for(var it = firstKey; it < lastKey; ++it) {
            if(!isBlackKey(it)) {
                whitePos.push({ key: it, rect: Qt.rect(cur_x, 0,  xScale * keyWidth, yScale*whiteHeight) });
                cur_x += xScale * keyWidth;
            }
        }

        cur_x = 0;

        for(var it = firstKey; it < lastKey; ++it) {
            switch(it % 12) {
            case 0: cur_x += xScale * keyWidth / 2; break;
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
            case 9: cur_x += xScale * keyWidth / 2; break;
            case 10: blackPos.push({ key: it, rect: Qt.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight) });
                     cur_x += xScale * keyWidth / 2; break;
            case 11: cur_x += xScale * keyWidth; break;
            default: break;
            }
        }
    }

    onFirstKeyChanged: recomputePos();
    onLastKeyChanged: recomputePos();
    onXScaleChanged: recomputePos()
    onYScaleChanged: recomputePos()
    Component.onCompleted: recomputePos();

    function isBlackKey(key)
    {
        var mod = key % 12;
        return (mod === 1) || (mod === 3) || (mod === 6) || (mod === 8) || (mod === 10);
    }

    function drawBlackKey(key, ctx, cur_x)
    {
        ctx.fillRect(cur_x, 0, xScale*blackWidth, yScale*blackHeight);
        ctx.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight);
    }

    function isPressed(key) { return pressedKeys.length > 0 && pressedKeys[0] === key; }
    Canvas
    {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");

            var cur_x = 0;

            var N = lastKey - firstKey;

            ctx.beginPath();
            ctx.strokeStyle = Styles.whiteKeyDetail;
            ctx.fillStyle = Styles.whiteKeyColor;
            ctx.lineWidth = 1;

            for(var it = firstKey; it < lastKey; ++it) {
                if(!isBlackKey(it)) {

                    if(isPressed(it)) {
                        ctx.fillStyle = Styles.whiteKeyDetail;
                    }

                    ctx.fillRect(cur_x, 0, xScale * keyWidth, yScale*whiteHeight);
                    ctx.rect(cur_x, 0, xScale * keyWidth, yScale*whiteHeight);
                    cur_x += xScale * keyWidth;

                    if(isPressed(it)) {
                        ctx.fillStyle = Styles.whiteKeyColor;
                    }
                }
            }

            ctx.stroke()
            ctx.closePath();

            ctx.beginPath();
            ctx.fillStyle = Styles.blackKeyColor;
            ctx.strokeStyle = Styles.blackKeyDetail;
            cur_x = 0;

            for(var it = firstKey; it < lastKey; ++it) {

                if(isPressed(it)) {
                    ctx.fillStyle = Styles.blackKeyDetail;
                }

                switch(it % 12) {
                case 0: cur_x += xScale * keyWidth / 2; break;
                case 1: drawBlackKey(it, ctx, cur_x); cur_x += xScale * keyWidth / 2; break;
                case 2: cur_x += xScale * keyWidth / 2; break;
                case 3: drawBlackKey(it, ctx, cur_x); cur_x += xScale * keyWidth / 2; break;
                case 4: cur_x += xScale * keyWidth ; break;
                case 5: cur_x += xScale * keyWidth / 2; break;
                case 6: drawBlackKey(it, ctx, cur_x); cur_x += xScale * keyWidth / 2; break;
                case 7: cur_x += xScale * keyWidth / 2; break;
                case 8: drawBlackKey(it, ctx, cur_x); cur_x += xScale * keyWidth / 2; break;
                case 9: cur_x += xScale * keyWidth / 2; break;
                case 10: drawBlackKey(it, ctx, cur_x); cur_x += xScale * keyWidth / 2; break;
                case 11: cur_x += xScale * keyWidth; break;
                default: break;
                }

                if(isPressed(it)) {
                    ctx.fillStyle = Styles.blackKeyColor;
                }

            }
            ctx.stroke();
            ctx.closePath();
        }
    }

    function posInRect(theRect, mouseX, mouseY)
    {
        return mouseX >= theRect.x
            && mouseX <= theRect.x + theRect.width
            && mouseY >= theRect.y
            && mouseY <= theRect.y + theRect.height;
    }

    function keyFromPos(mouseX, mouseY)
    {
        for(var it = 0; it < blackPos.length; ++it)
        {
            if(posInRect(blackPos[it].rect, mouseX, mouseY))
                return blackPos[it].key;
        }

        for(var it = 0; it < whitePos.length; ++it)
        {
            if(posInRect(whitePos[it].rect, mouseX, mouseY))
                return whitePos[it].key;
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            pressedKeys.push(keyFromPos(mouseX, mouseY))
            canvas.requestPaint()
        }
        onPositionChanged: {
            pressedKeys[0] = keyFromPos(mouseX, mouseY);
            canvas.requestPaint()
        }

        onReleased: {
            pressedKeys = [];
            canvas.requestPaint();
        }
    }
}
