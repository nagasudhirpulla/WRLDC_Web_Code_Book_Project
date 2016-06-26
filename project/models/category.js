var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.getAll = function (done) {
    db.get().query(SQLHelper.createSQLGetString('categories', ['name', 'id'], [], []) + " ORDER BY id", function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    })
};