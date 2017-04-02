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

    function isBlackKey(key)
    {
        var mod = key % 12;
        return (mod === 1) || (mod === 3) || (mod === 6) || (mod === 8) || (mod === 10);
    }

    function drawBlackKey(key, ctx, cur_x)
    {
        var blackHeight = 55;
        var blackWidth = 20;

        ctx.fillRect(cur_x, 0, xScale*blackWidth, yScale*blackHeight);
        ctx.rect(cur_x, 0, xScale*blackWidth, yScale*blackHeight);
    }

    Canvas
    {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");

            var cur_x = 0;

            //var keyWidth = 20;
            //var whiteHeight = 100;

            var N = lastKey - firstKey;

            ctx.beginPath();
            ctx.strokeStyle = Styles.whiteKeyDetail;
            ctx.fillStyle = Styles.whiteKeyColor;
            ctx.lineWidth = 1;

            for(var it = firstKey; it < lastKey; ++it) {
                if(!isBlackKey(it)) {
                    ctx.fillRect(cur_x, 0, xScale * keyWidth, yScale*whiteHeight);
                    ctx.rect(cur_x, 0, xScale * keyWidth, yScale*whiteHeight);
                    cur_x += xScale * keyWidth;
                }
            }

            ctx.stroke()
            ctx.closePath();

            ctx.beginPath();
            ctx.fillStyle = Styles.blackKeyColor;
            ctx.strokeStyle = Styles.blackKeyDetail;
            cur_x = 0;

            for(var it = firstKey; it < lastKey; ++it) {
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
            }
            ctx.stroke();
            ctx.closePath();
        }
    }
}
