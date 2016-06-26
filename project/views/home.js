document.onreadystatechange = function () {
    if (document.readyState == "interactive") {

    } else if (document.readyState == "complete") {
        onDomComplete();
    }
};
toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-bottom-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
};
function onDomComplete() {
    $(".chosen-select").chosen({enable_split_word_search:true,search_contains:true});
    $.ajax({
        //fetch categories from sever
        url: "http://localhost:3000/api/categories/",
        type: "GET",
        dataType: "json",
        success: function (data) {
            toastr["info"]("Categories fetch result is " + JSON.stringify(data.categories));
            fillCategoriesList(data.categories);
            //alert("Categories get fetch result is " + JSON.stringify(data));
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });

    $.ajax({
        //fetch entities from sever
        url: "http://localhost:3000/api/entities/",
        type: "GET",
        dataType: "json",
        success: function (data) {
            toastr["info"]("Entities get fetch result is " + JSON.stringify(data.entities));
            fillEntitiesList(data.entities);
            fillRequestedList(data.entities);
            //alert("Entities get fetch result is " + JSON.stringify(data));
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });

    $.ajax({
        //fetch rldcs from sever
        url: "http://localhost:3000/api/rldcs/",
        type: "GET",
        dataType: "json",
        success: function (data) {
            toastr["info"]("Rldcs get fetch result is " + JSON.stringify(data.rldcs));
            fillRldcsList(data.rldcs);
            //alert("Rldcs get fetch result is " + JSON.stringify(data));
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function fillCategoriesList(catsArray) {
    var catSelectEl = document.getElementById("category_select");
    removeOptions(catSelectEl);
    for (var i = 0; i < catsArray.length; i++) {
        catSelectEl.options[catSelectEl.options.length] = new Option(catsArray[i].name, catsArray[i].id);//new Option('Text 1', 'Value1');
    }
}

function fillRequestedList(entsArray) {
    var reqSelectEl = document.getElementById("request_entities_select");
    $(reqSelectEl).empty();
    $(reqSelectEl).trigger("chosen:updated");
    for (var i = 0; i < entsArray.length; i++) {
        $(reqSelectEl).append($("<option/>", {
            value: entsArray[i].id,
            text: entsArray[i].name
        }));
    }
    //change selected entities by the following statement
    $(reqSelectEl).val([entsArray[1].id, entsArray[3].id]).trigger("chosen:updated");
    $(reqSelectEl).trigger("chosen:updated");
}

function fillEntitiesList(entsArray) {
    var entsUl = document.getElementById("entity_selector");
    for (var i = 0; i < entsArray.length; i++) {
        var li = document.createElement("li");
        var checkbox = document.createElement('input');
        checkbox.type = "checkbox";
        checkbox.name = entsArray[i].name;
        checkbox.value = entsArray[i].name;
        li.appendChild(checkbox);
        li.appendChild(document.createTextNode(entsArray[i].name));
        entsUl.appendChild(li);
    }

}

function createCode() {
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/",
        type: "POST",
        data: {desc: "I am Sudhir"},
        dataType: "json",
        success: function (data) {
            toastr["info"]("Response is " + JSON.stringify(data.msg));
            //alert("Response is " + JSON.stringify(data));
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}
