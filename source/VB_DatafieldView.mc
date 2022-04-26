import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class VB_DatafieldView extends WatchUi.DataField {

    hidden var vbEarnt as Numeric;

    function initialize() {
        DataField.initialize();
        vbEarnt = 0.0f;
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc as Dc) as Void {
        var obscurityFlags = DataField.getObscurityFlags();

        // Top left quadrant so we'll use the top left layout
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

        // Top right quadrant so we'll use the top right layout
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

        // Bottom left quadrant so we'll use the bottom left layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

        // Bottom right quadrant so we'll use the bottom right layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            labelView.locY = labelView.locY - 20;
            var valueView = View.findDrawableById("value");
            valueView.locX = valueView.locX - 20 ;
            valueView.locY = valueView.locY + 8;

            var vbIconView = View.findDrawableById("VB_icon");
            vbIconView.locX = vbIconView.locX + 32;
            vbIconView.locY = vbIconView.locY + 8;
        }

        (View.findDrawableById("label") as Text).setText(Rez.Strings.label);
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void {
        // See Activity.Info in the documentation for available information.
        if(info has :calories){
            if(info.calories != null)
            {
                var calories = info.calories as Number;
                if(calories != null)
                {
                    vbEarnt = calories/142.0; //142 Calories in a VB
                }
            } else {
                vbEarnt = 0.0f;
            }
        }
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void {
        // Set the background color
        (View.findDrawableById("Background") as Text).setColor(getBackgroundColor());

        // Set the foreground color and value.
        var label = View.findDrawableById("label") as Text;
        var value = View.findDrawableById("value") as Text;

        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            label.setColor(Graphics.COLOR_WHITE);
            value.setColor(Graphics.COLOR_WHITE);
        } else {
            value.setColor(Graphics.COLOR_BLACK);
            value.setColor(Graphics.COLOR_BLACK);
        }
        value.setText(vbEarnt.format("%.1f"));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
