var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.getAll = function (done) {
    db.get().query(SQLHelper.createSQLGetString('associates', ['id', 'element_id', 'entity_id'], [], []), function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    })
};

exports.getByElement = function (element_id, done) {
    db.get().query(SQLHelper.createSQLGetString('associates', ['id', 'entity_id'], ['element_id'], ['=']), [element_id], function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    })
};