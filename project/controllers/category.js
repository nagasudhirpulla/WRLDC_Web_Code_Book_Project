var express = require('express');
var router = express.Router();
var Category = require('../models/category.js');

router.get('/', function (req, res) {
    Category.getAll(function (err, rows) {
        if (err) {
            res.send({'Error': err});
        }
        res.json({'categories': rows});
    });
});

module.exports = router;