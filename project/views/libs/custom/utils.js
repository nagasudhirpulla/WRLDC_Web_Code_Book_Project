function removeOptions(selectbox) {
    var i;
    for (i = selectbox.options.length - 1; i >= 0; i--) {
        selectbox.remove(i);
    }
}

function searchSelectForText(selectEl, text) {
    var options = selectEl.options;
    for (var i = 0; i < options.length; i++) {
        var option = options[i];
        var optionText = option.text;
        var lowerOptionText = optionText.toLowerCase();
        var lowerText = text.toLowerCase();
        var regex = new RegExp("^" + text, "i");
        var match = optionText.match(regex);
        var contains = lowerOptionText.indexOf(lowerText) != -1;
        if (match || contains) {
            //option found!!!
            return option.value;
        }
    }
    //option text not found, so return a default value in this case, 1
    return 1;
}