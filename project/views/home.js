var mRldcIdsArray = [];
var mGrid; //The cell grid object.
var mGridElId = "#myGrid";
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
    $(mGridElId).on('mouseenter', ".slick-row", function () {
        $(this).addClass('row-hovered');
    }).on('mouseleave', ".slick-row", function () {
        $(this).removeClass('row-hovered');
    });
    $(".chosen-select").chosen({enable_split_word_search: true, search_contains: true});
    getDisplayCodes(true);
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

    /*$.ajax({
     //fetch entities from wrldc sever
     url: "http://103.7.130.119:8181/json.ashx?r=owns",
     type: "GET",
     crossDomain: true,
     dataType: "jsonp",
     success: function (data) {
     toastr["info"]("Entities get fetch result is " + JSON.stringify(data));
     fillEntitiesList(data);
     fillRequestedList(data);
     //alert("Entities get fetch result is " + JSON.stringify(data));
     },
     error: function (jqXHR, textStatus, errorThrown) {
     console.log(textStatus, errorThrown);
     }
     });*/

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
    var selElArray = ["category_select", "category_select_edit"];
    for (var k = 0; k < selElArray.length; k++) {
        var catSelectEl = document.getElementById(selElArray[k]);
        removeOptions(catSelectEl);
        for (var i = 0; i < catsArray.length; i++) {
            catSelectEl.options[catSelectEl.options.length] = new Option(catsArray[i].name, catsArray[i].id);//new Option('Text 1', 'Value1');
        }
    }
}

function fillRequestedList(entsArray) {
    var selElArray = ["request_entities_select", "request_entities_select_edit"];
    for (var k = 0; k < selElArray.length; k++) {
        var reqSelectEl = document.getElementById(selElArray[k]);
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
}

/*function fillRequestedList(entsArray) {
 var reqSelectEl = document.getElementById("request_entities_select");
 $(reqSelectEl).empty();
 $(reqSelectEl).trigger("chosen:updated");
 for (var i = 0; i < entsArray.length; i++) {
 $(reqSelectEl).append($("<option/>", {
 value: entsArray[i].id,
 text: entsArray[i].sname
 }));
 }
 //change selected entities by the following statement
 $(reqSelectEl).val([entsArray[1].id, entsArray[3].id]).trigger("chosen:updated");
 $(reqSelectEl).trigger("chosen:updated");
 }*/

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

/*
 function fillEntitiesList(entsArray) {
 var entsUl = document.getElementById("entity_selector");
 for (var i = 0; i < entsArray.length; i++) {
 var li = document.createElement("li");
 var checkbox = document.createElement('input');
 checkbox.type = "checkbox";
 checkbox.name = entsArray[i].sname;
 checkbox.value = entsArray[i].sname;
 li.appendChild(checkbox);
 li.appendChild(document.createTextNode(entsArray[i].sname));
 entsUl.appendChild(li);
 }
 }
 */


function createCode() {
    //http://stackoverflow.com/questions/17112852/get-the-new-record-primary-key-id-from-mysql-insert-query
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
                toastCode(data.new_code);
                console.log("The code id issued is " + data.new_code);
                if (isOtherCodesRequired) {
                    createOtherCodes(data.new_code, nl_code, nr_code, er_code, sr_code, ner_code);
                }
                if (request_entities_ids_array.length > 0) {
                    createRequestingEntities(data.new_code, request_entities_ids_array);
                }
                //Refresh the codes list after 0.5 seconds
                window.setTimeout(getDisplayCodes, 500);
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

function createZeroCode() {
    //For creating a code zero. This will be a dummy code just for the sake of code sequence restart
    //search for 'other' category in the categories array else set category = 1
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/create_explicit/",
        type: "POST",
        data: {
            code: 0,
            desc: "Zero Code",
            cat: searchSelectForText(document.querySelector("#category_select"), "other"),
            elem_id: null,
            req_array: []
        },
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Code couldn't be inserted\nTry Again... ");
                console.log("Code couldn't be inserted, Error: " + JSON.stringify(data.Error));
            } else {
                //we get code id but not code, so do get query with code id and get the codo to be issued and toast it
                console.log("The code id issued is " + JSON.stringify(data.new_code));
                toastCode(data.new_code);
                //Refresh the codes list after 0.5 seconds
                window.setTimeout(getDisplayCodes, 500);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function month_start_button_click() {
    if (confirm("Create zero code???")) {
        if (confirm("*****Are You Sure, If not sure press cancel*****")) {
            createZeroCode();
        }
    }
}

function toastCode(new_code_id) {
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/?id=" + new_code_id,
        type: "GET",
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                //toastr["warning"]("Codes couldn't be loaded from server\nTry Again... ");
                console.log("get code couldn't be loaded from server, Error: " + JSON.stringify(data.Error));
            } else {
                toastr["success"]("The code issued is " + JSON.stringify(data.codes[0].code));
                console.log("The code issued is " + JSON.stringify(data.codes[0].code));
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function getDisplayCodes(recreate) {
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/fordisplay/",
        type: "GET",
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Codes couldn't be loaded from server\nTry Again... ");
                console.log("Codes couldn't be loaded from server, Error: " + JSON.stringify(data.Error));
            } else {
                //console.log("Codes loaded for display are \n" + JSON.stringify(data.codes));
                if (recreate) {
                    var gridData = addButtonColumns(data.codes);
                    mGrid = setUpGrid(gridData);
                    $(mGridElId).trigger($.extend({}, jQuery.Event("keydown"), {
                        keyCode: 65,
                        ctrlKey: true,
                        shiftKey: true
                    }));
                } else {
                    var gridData = addButtonColumns(data.codes);
                    mGrid.setData(gridData);
                    mGrid.render();
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}

function addButtonColumns(data) {
    for (var i = 0; i < data.length; i++) {
        data[i]['edit'] = '';
    }
    return data;
}

function editCodeOfRow(row) {
    console.log("Edit button of row " + row + " pressed!!!");
    if (mGrid.getData()[row]['id']) {
        populateEditCodeUI(mGrid.getData()[row]['id']);
    }
}

function populateEditCodeUI(recordId) {
    $("#edit_dialog").dialog({
        bgiframe: true,
        title: " ",
        position: 'center',
        width: $(window).width() - 180,
        height: $(window).height() - 180,
        modal: true
    });
    //get the code values from server
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/?id=" + recordId,
        type: "GET",
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Code couldn't be loaded from server\nTry Again... ");
                console.log("get code couldn't be loaded from server, Error: " + JSON.stringify(data.Error));
                $("#edit_dialog").dialog("close");
            } else {
                console.log("The Edit code data is " + JSON.stringify(data.codes[0]));
                var codeObj = data.codes[0];
                $("#code_edit_span").text(codeObj.id + " / " + codeObj.code);
                $("#category_select_edit").val(codeObj.categoryId);
                $("#code_description_input_edit").val(codeObj.description);
                $("#is_cancelled_edit_chkbox").attr('checked', codeObj.is_cancelled != 0 ? true : false);
                if (codeObj.requestedbyIds) {
                    $("#request_entities_select_edit").val(codeObj.requestedbyIds.split(", ").map(Number)).trigger("chosen:updated");
                }
                var otherCodes = [];
                if (codeObj.othercodes) {
                    var otherCodes = codeObj.othercodes.split(', ');
                }
                for (var i = 0; i < otherCodes.length; i++) {
                    if (otherCodes[i].indexOf("NLDC ") == 0) {
                        $("#nl_code_edit").val(otherCodes[i].substring(5));
                    } else if (otherCodes[i].indexOf("NRLDC ") == 0) {
                        $("#nr_code_edit").val(otherCodes[i].substring(6));
                    } else if (otherCodes[i].indexOf("ERLDC ") == 0) {
                        $("#er_code_edit").val(otherCodes[i].substring(6));
                    } else if (otherCodes[i].indexOf("SRLDC ") == 0) {
                        $("#sr_code_edit").val(otherCodes[i].substring(6));
                    } else if (otherCodes[i].indexOf("NERLDC ") == 0) {
                        $("#ner_code_edit").val(otherCodes[i].substring(7));
                    }
                }
                //set code time
                if(codeObj.codetime != null && codeObj.codetime != "" && codeObj.codetime != "null"){
                    var code_time = new Date(codeObj.codetime);
                    $("#code_time_edit").val(getTimeString(code_time));
                    //set code date
                    $("#code_date_edit").val(getDateString(code_time));
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
            toastr["warning"]("Code couldn't be loaded from server\nTry Again... ");
            $("#edit_dialog").dialog("close");
        }
    });
}

function editCode() {
    var main_code = $("#code_edit_span").text().split("/")[0].trim();
    var is_cancelled = document.getElementById('is_cancelled_edit_chkbox').checked ? 1 : 0;
    var isOtherCodesRequired = true;
    var desc = document.getElementById("code_description_input_edit").value;
    var cat_sel = document.getElementById("category_select_edit");
    var cat_id = cat_sel.options[cat_sel.selectedIndex].value;
    var request_entities_ids_array = $("#request_entities_select_edit").val();
    var nl_code = document.getElementById("nl_code_edit").value;
    var nr_code = document.getElementById("nr_code_edit").value;
    var er_code = document.getElementById("er_code_edit").value;
    var sr_code = document.getElementById("sr_code_edit").value;
    var ner_code = document.getElementById("ner_code_edit").value;
    if (nl_code.trim() == "" && nr_code.trim() == "" && er_code.trim() == "" && sr_code.trim() == "" && ner_code.trim() == "") {
        isOtherCodesRequired = false;
    }
    //getting values for editing other rldc codes
    var mainCodesArray = [];
    var rldcsIdsArray = [];
    var otherCodesArray = [];
    if (isOtherCodesRequired) {
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
    }
    //editing the element is pending
    if (request_entities_ids_array.length > 0) {
        var mainCodesArrayForReqEnts = [];
        for (var i = 0; i < request_entities_ids_array.length; i++) {
            mainCodesArrayForReqEnts.push(main_code);
        }
        var ReqEntsValues = {code_ids: mainCodesArrayForReqEnts, entity_ids: request_entities_ids_array};//[main_code_id, requesting_entity_id]
        //console.log("Requesting entities insertion values array is " + JSON.stringify(ReqEntsValues));
    }
    var dateObj = new Date($("#code_date_edit").val() + " " + $("#code_time_edit").val());
    var dateString = "";
    if (isDateObjectValid(dateObj)) {
        //we can edit the date time in the server by using the dateObj
        dateString = getDBDateTimeString(dateObj);
    }
    var ajaxData = {
        record_id: main_code,
        is_cancelled: is_cancelled,
        rldc_ids: rldcsIdsArray,
        other_codes: otherCodesArray,
        cat: cat_id,
        elem_id: null,
        req_entity_ids: request_entities_ids_array,
        desc: desc,
        code_time: dateString
    };
    console.log("Edit code ajax data is " + JSON.stringify(ajaxData));
    $.ajax({
        //create code through post request
        url: "http://localhost:3000/api/codes/",
        type: "PUT",
        data: ajaxData,
        dataType: "json",
        success: function (data) {
            //console.log(data);
            if (data["Error"]) {
                toastr["warning"]("Code couldn't be updated\nTry Again... ");
                console.log("Code couldn't be updated, Error: " + JSON.stringify(data.Error));
            } else {
                toastr["success"]("Code updated");
                console.log("The code id updated is " + data["updated_code"]);
                //Refresh the codes list after 0.5 seconds
                window.setTimeout(getDisplayCodes, 500);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus, errorThrown);
        }
    });
}