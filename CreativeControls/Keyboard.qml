import QtQuick 2.6


// A piano keyboard.
Item
{

    property int firstKey: 17
    property int lastKey: 75

    property color whiteKeyColor: "#777777"
    property color blackKeyColor: "#444444"
    property color whiteKeyDetail: "#99BB99"
    property color blackKeyDetail: "#99BB99"

    function isBlackKey(key)
    {
        var mod = key % 12;
        return (mod === 1) || (mod === 3) || (mod === 6) || (mod === 8) || (mod === 10);
    }

    function drawBlackKey(key, ctx, cur_x)
    {
        var blackHeight = 55;
        var blackWidth = 20;

        ctx.fillRect(cur_x, 0, blackWidth, blackHeight);
        ctx.rect(cur_x, 0, blackWidth, blackHeight);
    }

    Canvas
    {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");

            var cur_x = 0;

            var keyWidth = 20;
            var whiteHeight = 100;

            var N = lastKey - firstKey;

            ctx.beginPath();
            ctx.strokeStyle = whiteKeyDetail;
            ctx.fillStyle = whiteKeyColor;
            ctx.lineWidth = 1;

            for(var it = firstKey; it < lastKey; ++it) {
                if(!isBlackKey(it)) {
                    ctx.fillRect(cur_x, 0, keyWidth, whiteHeight);
                    ctx.rect(cur_x, 0, keyWidth, whiteHeight);
                    cur_x += keyWidth;
                }
            }

            ctx.stroke()
            ctx.closePath();

            ctx.beginPath();
            ctx.fillStyle = blackKeyColor;
            ctx.strokeStyle = blackKeyDetail;
            cur_x = 0;

            for(var it = firstKey; it < lastKey; ++it) {
                switch(it % 12) {
                case 0: cur_x += keyWidth / 2; break;
                case 1: drawBlackKey(it, ctx, cur_x); cur_x += keyWidth / 2; break;
                case 2: cur_x += keyWidth / 2; break;
                case 3: drawBlackKey(it, ctx, cur_x); cur_x += keyWidth / 2; break;
                case 4: cur_x += keyWidth ; break;
                case 5: cur_x += keyWidth / 2; break;
                case 6: drawBlackKey(it, ctx, cur_x); cur_x += keyWidth / 2; break;
                case 7: cur_x += keyWidth / 2; break;
                case 8: drawBlackKey(it, ctx, cur_x); cur_x += keyWidth / 2; break;
                case 9: cur_x += keyWidth / 2; break;
                case 10: drawBlackKey(it, ctx, cur_x); cur_x += keyWidth / 2; break;
                case 11: cur_x += keyWidth; break;
                default: break;
                }
            }
            ctx.stroke();
            ctx.closePath();
        }
    }
}
