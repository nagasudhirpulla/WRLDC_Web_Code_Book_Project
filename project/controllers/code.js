var express = require('express');
var router = express.Router();
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

module.exports = router;
