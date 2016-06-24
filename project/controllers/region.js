var express = require('express');
var router = express.Router();
var Region = require('../models/region.js');

router.get('/', function (req, res) {
    Region.getAll(function (err, rows) {
        if (err) {
            res.send({'Error': err});
        }
        res.json({'regions': rows});
    });
});

module.exports = router;