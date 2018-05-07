import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0

// Slider with a min and max
Rectangle
{
    id: rangeSlider

    width : 200
    height : 100
    // onWidthChanged: handle.updateHandle();
    // onHeightChanged: handle.updateHandle();
    property var styles: DarkStyle

    color : styles.sliderBackgroundColor
    border.width : orientation ==  Qt.Vertical ? width / 25. : height / 25.
    border.color : styles.sliderBackgroundColor

    radius : styles.cornerRadius

    // the value is between 0 and 1.
    property real value //: initialValue;

    property real minValue: initialMinValue
    property real maxValue: initialMaxValue

    property real initialMinValue : 0.4
    property real initialMaxValue : 0.8

    // value mapping
    property var mapFunc : function(linearVal){return linearVal}

    // vertical (Qt.Vertical) or horizontal (Qt.Horizontal) slider
    property int orientation : Qt.Horizontal

    property bool __updating: false


    // by reseting, the handle width and height are initialized according to the initalValue
    Component.onCompleted: reset();

    // function called when updating the value from outside
    function updateValue()
    {
        // TODO use a function instead so that one can use linear, or log, or whatever mapping.
        if(!__updating)
        {
            rangeSlider.value = mapFunc();
        }
    }

    function reset(){
        minHandle.reset();
        maxHandle.reset();
    }
    property real handleSize: rangeSlider.border.width * 5.

    property color handleColor: styles.handleColor
    Rectangle{
        id: range

        anchors{
            top: (orientation == Qt.Vertical) ? maxHandle.bottom : undefined
            right: (orientation == Qt.Vertical) ? undefined : maxHandle.left
            horizontalCenter: (orientation == Qt.Vertical) ? rangeSlider.horizontalCenter : undefined
            verticalCenter: (orientation == Qt.Vertical) ? undefined: rangeSlider.verticalCenter

        }
        width: (orientation == Qt.Vertical) ? rangeSlider.width * 0.9 :  maxHandle.x - (minHandle.x + minHandle.width)
        height: (orientation == Qt.Vertical) ? minHandle.y - (maxHandle.y + maxHandle.height) : rangeSlider.height *0.9

        color: styles.colorOn

        function updateValues(offset){
            console.log(offset)

            if(orientation == Qt.Vertical)
            {
                var yMax = maxHandle.y + offset;
                var yMin = minHandle.y + offset;

                var clampedMaxY = Utils.clamp(yMax + handleSize/2., handleSize/2., minHandle.y -  handleSize/2.);
                var clampedMinY = Utils.clamp(yMin+ handleSize/2., yMax + 3.*handleSize/2., rangeSlider.height -  handleSize/2.);

                rangeSlider.maxValue = Utils.clamp(Utils.rescale(rangeSlider.height - clampedMaxY, 3.*handleSize/2.,rangeSlider.height - handleSize/2., 0., 1.)
                                                   ,0,1);
                rangeSlider.minValue = Utils.clamp(Utils.rescale(rangeSlider.height - clampedMinY, handleSize/2., rangeSlider.height - 3.*handleSize/2., 0., 1.)
                                                   ,0,1);
            }
            else if(orientation == Qt.Horizontal)
            {
                console.log("maxHandle.x "+maxHandle.x)
                var xMax = maxHandle.x + offset;
                var xMin = minHandle.x + offset;

                var clampedMaxX =  Utils.clamp(xMax + handleSize/2., minHandle.x + 3.*handleSize/2., rangeSlider.width -  handleSize/2.);
                var clampedMinX = Utils.clamp(xMin + handleSize/2., handleSize/2., xMax -  handleSize/2.);

                console.log((xMax+ handleSize/2.)+" max, after " + clampedMaxX)
                console.log("rescale min" +(  minHandle.x +3.*handleSize/2.))
                console.log("rescale max" +(rangeSlider.width - handleSize/2.))

             //   rangeSlider.maxValue = Utils.clamp(Utils.rescale(clampedMaxX, 3.*handleSize/2.,rangeSlider.width - handleSize/2., 0., 1.)
               //                                    ,0,1);
            var tmp = Utils.clamp(Utils.rescale(clampedMaxX, 3.*handleSize/2.,rangeSlider.width - handleSize/2., 0., 1.)
                                                                       ,0,1);
                console.log("maxValue" +tmp)
               rangeSlider.maxValue = tmp

                rangeSlider.minValue = Utils.clamp(Utils.rescale(clampedMinX, handleSize/2., rangeSlider.width - 3.*handleSize/2., 0., 1.)
                                                   ,0,1);
            }
        }
    }

    Rectangle{
        id: minHandle

        width: (orientation == Qt.Vertical) ? rangeSlider.width : handleSize
        height: (orientation == Qt.Vertical) ? handleSize : rangeSlider.height

        x: (orientation == Qt.Vertical) ? 0 : Utils.rescale(rangeSlider.minValue,0.,1.,
                                                            handleSize / 2.,
                                                            rangeSlider.width - 3.*handleSize/2.) - handleSize/2.;
        y: (orientation == Qt.Vertical) ? Utils.rescale(1. - rangeSlider.minValue,0.,1.,
                                                        3. * handleSize / 2.,
                                                        rangeSlider.height - handleSize/2.) - handleSize/2.
                                        : 0;
        color: styles.background//range.color
        // border.color: Styles.background
        // border.width: 4
        /*
        Rectangle{
            id: top
            width: (orientation == Qt.Vertical) ? minHandle.width : 3
            height: (orientation == Qt.Vertical) ? 3 : minHandle.height
            color: Styles.background
        }*/


        function moveHandle(mouseX,mouseY)
        {
            if(orientation == Qt.Vertical)
            {
                var clampedY = Utils.clamp(mouseY, maxHandle.y + maxHandle.height + handleSize/2., rangeSlider.height -  handleSize/2.);
                rangeSlider.minValue = Utils.rescale(rangeSlider.height - clampedY, handleSize/2., rangeSlider.height - 3.*handleSize/2., 0., 1.);
            }
            else
            {
                var clampedX = Utils.clamp(mouseX, handleSize/2., maxHandle.x - handleSize/2.);
                rangeSlider.minValue = Utils.rescale(clampedX, handleSize/2.,rangeSlider.width - 3.*handleSize/2.,0.,1.);

                //rangeSlider.minValue = Utils.clampRescale(mouseX, minHandle.width/2.,rangeSlider.width - minHandle.width/2.,0.,rangeSlider.maxValue);
            }

            // __updating = false;
        }
        function reset(){
            rangeSlider.minValue = rangeSlider.initialMinValue;
        }
    }


    Rectangle{
        id: maxHandle

        width: (orientation == Qt.Vertical) ? rangeSlider.width : handleSize
        height: (orientation == Qt.Vertical) ? handleSize : rangeSlider.height

        x: (orientation == Qt.Vertical) ? 0 : Utils.rescale(rangeSlider.maxValue,0.,1.,
                                                            handleSize/2., rangeSlider.width- handleSize/2.) - handleSize/2.;
        y: (orientation == Qt.Vertical) ? Utils.rescale(1. - rangeSlider.maxValue,0.,1.,
                                                        handleSize/2.,rangeSlider.height - 3.*handleSize/2.) - handleSize/2.
                                        : 0


        color: styles.background//range.color//Styles.base
        //border.color: Styles.background
        //border.width: 4
        /* Rectangle{
            x: (orientation == Qt.Vertical) ? 0 : maxHandle.width
            y: (orientation == Qt.Vertical) ? maxHandle.height : 0
            width: (orientation == Qt.Vertical) ? maxHandle.width : 3
            height: (orientation == Qt.Vertical) ? 3 : maxHandle.height
            color: Styles.background
        }*/
        function moveHandle(mouseX,mouseY)
        {
            if(orientation == Qt.Vertical)
            {
                var clampedY = Utils.clamp(mouseY, handleSize/2., minHandle.y -  handleSize/2.);
                rangeSlider.maxValue = Utils.rescale(rangeSlider.height - clampedY, 3.*handleSize/2.,rangeSlider.height - handleSize/2., 0., 1.);
            }
            else
            {
                var clampedX = Utils.clamp(mouseX, minHandle.x +  minHandle.width +  handleSize/2., rangeSlider.width - handleSize/2.);
                rangeSlider.maxValue = Utils.rescale(clampedX, handleSize/2., rangeSlider.width - handleSize/2.,0.,1.);
            }

        }
        function reset(){
            rangeSlider.maxValue = rangeSlider.initialMaxValue
        }

    }

    Text
    {
        anchors.fill: minHandle
        // anchors.horizontalCenter: range.horizontalCenter

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: rangeSlider.minValue.toFixed(2)
        color: styles.labelColor
        font.bold: true
    }
    Text
    {

        anchors.fill: maxHandle

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: rangeSlider.maxValue.toFixed(2)
        color: styles.labelColor
        font.bold: true
    }

    MouseArea
    {
        id: mouseArea

        anchors.fill : parent
        property var handlePressed: null;
        property bool moveRange: false;
        property real offset: 0
        onPressed :
        {
            __updating = true;
            if(orientation == Qt.Vertical)
            {
                if(mouseY < maxHandle.y  + maxHandle.height){
                    handlePressed = maxHandle;
                    handlePressed.moveHandle(mouseX,mouseY);
                }
                else if(mouseY > minHandle.y ){
                    handlePressed = minHandle;
                    handlePressed.moveHandle(mouseX,mouseY);
                }
                else {
                    moveRange = true;
                    offset = mouseY - range.y;
                }
            }
            else if(orientation == Qt.Horizontal)
            {
                if(mouseX < minHandle.x + minHandle.width){
                    handlePressed = minHandle;
                    handlePressed.moveHandle(mouseX,mouseY);
                }
                else if(mouseX > maxHandle.x ){
                    handlePressed = maxHandle;
                    handlePressed.moveHandle(mouseX,mouseY);
                }
                else {
                    moveRange = true;
                    offset = mouseX - range.x;
                }
            }
        }

        onPositionChanged: {
            if(handlePressed)
                handlePressed.moveHandle(mouseX,mouseY);
            else if(moveRange)
            {
                var newVal = 0;
                if(orientation == Qt.Vertical)
                {
                    newVal = Math.min(Math.max(handleSize,mouseY-offset),rangeSlider.height-(range.height + handleSize))
                    newVal -= range.y;
                }
                else if(orientation == Qt.Horizontal)
                {
                   newVal = Utils.clamp(mouseX-offset,handleSize,rangeSlider.width-(range.width + handleSize));
                   newVal -= range.x;
                }

               range.updateValues(newVal)
            }

        }

        onReleased: { handlePressed = null; __updating = false;moveRange = false;}

        onDoubleClicked:
        {
            if(Utils.inside(mouseX,mouseY,maxHandle.x,maxHandle.y,
                            maxHandle.width,maxHandle.height))
            {
                maxHandle.reset();
            }
            else if(Utils.inside(mouseX,mouseY,minHandle.x,minHandle.y,
                                 minHandle.width,minHandle.height))
            {
                minHandle.reset();
            }
            else
                rangeSlider.reset()


        }
    }

}

