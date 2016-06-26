var express = require('express');
var router = express.Router();
var Code = require('../models/code.js');

router.get('/', function (req, res) {
    Code.getAll(function (err, rows) {
        if (err) {
            res.send({'Error': err});
        }
        res.json({'codes': rows});
    });
});

router.post('/', function (req, res) {
    res.json({'msg': req.body.desc});
});
module.exports = router;