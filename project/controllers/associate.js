var express = require('express');
var router = express.Router();
var Associate = require('../models/associate.js');

router.get('/', function (req, res) {
    Associate.getAll(function (err, rows) {
        if (err) {
            res.send({'Error': err});
        }
        res.json({'associates': rows});
    });
});

router.get('/getByElement', function (req, res) {
    //console.log("Associate controller getByElement function route element_id query param is "+req.query.element_id);
    Associate.getByElement(req.query.element_id, function (err, rows) {
        if (err) {
            res.send({'Error': err});
        }
        res.json({'associates': rows});
    });
});

module.exports = router;