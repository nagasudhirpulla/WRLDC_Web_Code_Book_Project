var express = require('express');
var router = express.Router();
var Entity = require('../models/entity.js');

router.get('/', function (req, res) {
    Entity.getAll(function (err, rows) {
        if (err) {
            res.json({'Error': err});
        }
        res.json({'entities': rows});
    });
});

module.exports = router;