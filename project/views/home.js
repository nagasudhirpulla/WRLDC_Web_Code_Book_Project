var mRldcIdsArray = [];
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
    $(".chosen-select").chosen({enable_split_word_search: true, search_contains: true});
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

function fillRldcsList(rldcsArray) {
    mRldcIdsArray = rldcsArray;
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
    var isOtherCodesRequired = true;
    if (!confirm("********** Create the code ??? **********")) {
        return;
    }
    var desc = document.getElementById("code_description_input").value;
    var cat_sel = document.getElementById("category_select");
    var cat_id = cat_sel.options[cat_sel.selectedIndex].value;
    var request_entities_ids_array = $("#request_entities_select").val();
    var nl_code = document.getElementById("nl_code").value;
    var nr_code = document.getElementById("nr_code").value;
    var er_code = document.getElementById("er_code").value;
    var sr_code = document.getElementById("sr_code").value;
    var ner_code = document.getElementById("ner_code").value;
    if (nl_code.trim() == "" && nr_code.trim() == "" && er_code.trim() == "" && sr_code.trim() == "" && ner_code.trim() == "") {
        isOtherCodesRequired = false;
    }
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/",
        type: "POST",
        data: {desc: desc, cat: cat_id, elem_id: null, req_array: request_entities_ids_array},
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Code couldn't be inserted\nTry Again... ");
                console.log("Code couldn't be inserted, Error: " + JSON.stringify(data.Error));
            } else {
                toastr["success"]("The code issued is " + JSON.stringify(data.new_code));
                console.log("The code issued is " + JSON.stringify(data.new_code));
                if (isOtherCodesRequired) {
                    createOtherCodes(data.new_code, nl_code, nr_code, er_code, sr_code, ner_code);
                }
                if (request_entities_ids_array.length > 0) {
                    createRequestingEntities(data.new_code, request_entities_ids_array);
                }
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function createOtherCodes(main_code, nl_code, nr_code, er_code, sr_code, ner_code) {
    //mRldcIdsArray
    var mainCodesArray = [];
    var rldcsIdsArray = [];
    var otherCodesArray = [];
    for (var i = 0; i < mRldcIdsArray.length; i++) {
        if (mRldcIdsArray[i].name == "NLDC" && nl_code.trim().length != 0) {
            mainCodesArray.push(main_code);
            rldcsIdsArray.push(mRldcIdsArray[i].id);
            otherCodesArray.push(nl_code);
        } else if (mRldcIdsArray[i].name == "NRLDC" && nr_code.trim().length != 0) {
            mainCodesArray.push(main_code);
            rldcsIdsArray.push(mRldcIdsArray[i].id);
            otherCodesArray.push(nr_code);
        } else if (mRldcIdsArray[i].name == "SRLDC" && sr_code.trim().length != 0) {
            mainCodesArray.push(main_code);
            rldcsIdsArray.push(mRldcIdsArray[i].id);
            otherCodesArray.push(sr_code);
        } else if (mRldcIdsArray[i].name == "ERLDC" && er_code.trim().length != 0) {
            mainCodesArray.push(main_code);
            rldcsIdsArray.push(mRldcIdsArray[i].id);
            otherCodesArray.push(er_code);
        } else if (mRldcIdsArray[i].name == "NERLDC" && ner_code.trim().length != 0) {
            mainCodesArray.push(main_code);
            rldcsIdsArray.push(mRldcIdsArray[i].id);
            otherCodesArray.push(ner_code);
        }
    }
    var values = {codes: otherCodesArray, rldc_ids: rldcsIdsArray, code_ids: mainCodesArray};//[main_code_id, rldc_id,optional_code];
    console.log("Other RLDCs insertion values array is " + JSON.stringify(values));
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/optional_codes/",
        type: "POST",
        data: {values: values},
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Other RLDC codes couldn't be inserted\nTry Again... ");
                console.log("Other RLDC codes couldn't be inserted, Error: " + JSON.stringify(data.Error));
            } else {
                toastr["success"](data.numOtherCodes + " Other RLDC codes inserted");
                console.log(data.numOtherCodes + " Other RLDC codes inserted");
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function createRequestingEntities(main_code, request_entities_ids_array) {
    var mainCodesArray = [];
    for (var i = 0; i < request_entities_ids_array.length; i++) {
        mainCodesArray.push(main_code);
    }
    var values = {code_ids: mainCodesArray, entity_ids: request_entities_ids_array};//[main_code_id, requesting_entity_id]
    console.log("Requesting entities insertion values array is " + JSON.stringify(values));
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/code_requests/",
        type: "POST",
        data: {values: values},
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Requesting Entities couldn't be inserted\nTry Again... ");
                console.log("Requesting Entities couldn't be inserted, Error: " + JSON.stringify(data.Error));
            } else {
                toastr["success"](data.numRequesting + " Requesting Entities inserted");
                console.log(data.numRequesting + " Requesting Entities inserted");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}