var express = require('express');
var router = express.Router();
var SQLHelper = require('../helpers/sqlHelper.js');
var ArrayHelper = require('../helpers/arrayHelper.js');
var DateHelper = require('../helpers/date.js');
var Code = require('../models/code.js');

router.get('/fordisplay', function (req, res) {
    Code.getForDisplay(null, function (err, rows) {
        if (err) {
            res.json({'Error': err});
        }
        res.json({'codes': rows});
    });
});

router.get('/', function (req, res) {
    //console.log("get req params for get single are " + JSON.stringify(req.query));
    Code.getForEdit(req.query.id, function (err, rows) {
        if (err) {
            res.json({'Error': err});
        }
        res.json({'codes': rows});
    });
});

router.post('/create_explicit', function (req, res) {
    var code = req.body["code"];
    var cat = req.body["cat"];
    var desc = req.body["desc"];
    var req_array = req.body["req_array[]"];
    var elem_id = req.body["elem_id"];
    if (code == null || code == "") {
        res.json({'Error': "Code not specified"});
    }
    if (elem_id == "" || elem_id == "null") {
        elem_id = null;
    }
    //console.log("Code create explicit post request body object is " + JSON.stringify(req.body));
    Code.createExplicit(code, cat, desc, elem_id, function (err, inserted_code) {
        if (err) {
            res.json({'Error': err});
        }
        res.json({'new_code': inserted_code});
    });
});

router.post('/', function (req, res) {
    var cat = req.body["cat"];
    var desc = req.body["desc"];
    var req_array = req.body["req_array[]"];
    var elem_id = req.body["elem_id"];
    if (elem_id == "" || elem_id == "null") {
        elem_id = null;
    }
    //console.log("Code create post request body object is " + JSON.stringify(req.body));
    Code.create(cat, desc, elem_id, function (err, inserted_code) {
        if (err) {
            res.json({'Error': err});
        }
        res.json({'new_code': inserted_code});
    });
});

router.put('/', function (req, res) {
    //console.log("The code update request body is " + JSON.stringify(req.body) + "\n");
    var record_id = req.body["record_id"];
    var is_cancelled = req.body["is_cancelled"];
    var rldc_ids = req.body["rldc_ids[]"];
    var rldc_codes = req.body["other_codes[]"];
    var cat = req.body["cat"];
    var elemId = req.body["element_id"];
    var entity_ids = req.body["req_entity_ids[]"];
    var desc = req.body["desc"];
    var code_time = req.body["code_time"];
    if (elemId == "" || elemId == "null") {
        elemId = null;
    }
    var SQLString = "START TRANSACTION READ WRITE;UPDATE codes SET category_id=?,description=?,element_id=?,is_cancelled=? WHERE id=?;";
    var values = [cat, desc, elemId, is_cancelled, record_id];
    if (rldc_ids && rldc_ids.length > 0 && rldc_ids.length == rldc_codes.length) {
        //include rldc ids update code
        SQLString += "DELETE FROM optional_codes WHERE code_id=?;";
        values = values.concat(record_id);
        var rldc_codes_SQL = SQLHelper.createSQLInsertString("optional_codes", ["code_id", "rldc_id", "code"], [ArrayHelper.createArrayFromSingleElement(record_id, rldc_ids.length), rldc_ids, rldc_codes]);
        SQLString += rldc_codes_SQL['SQLQueryString'];
        values = values.concat(rldc_codes_SQL['SQLQueryValues']);
    }
    if (DateHelper.isDateObjectValid(new Date(code_time)) && code_time != "" && code_time != null && code_time != "null") {
        //we have a valid datetime to update
        var code_time_value = DateHelper.getDateTimeString(new Date(code_time));
        SQLString += "DELETE FROM times WHERE code_id = ?;";
        values = values.concat(record_id);
        var code_time_SQL = SQLHelper.createSQLInsertString("times", ["code_id", "time"], [[record_id], [code_time_value]]);
        SQLString += code_time_SQL['SQLQueryString'];
        values = values.concat(code_time_SQL['SQLQueryValues']);
    }
    if (entity_ids && entity_ids.length > 0) {
        //we have to update the requesting entity ids list
        SQLString += "DELETE FROM code_requests WHERE code_id=?;";
        values = values.concat(record_id);
        var req_entities_SQL = SQLHelper.createSQLInsertString("code_requests", ["code_id", "entity_id"], [ArrayHelper.createArrayFromSingleElement(record_id, entity_ids.length), entity_ids]);
        SQLString += req_entities_SQL['SQLQueryString'];
        values = values.concat(req_entities_SQL['SQLQueryValues']);
    }
    SQLString += "COMMIT;";
    console.log("The code update SQL is " + SQLString + "\n");
    console.log("The code update SQL values are " + values + "\n");
    res.json({'updated_code': record_id});
});


module.exports = router;
