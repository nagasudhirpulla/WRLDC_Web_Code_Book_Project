var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.create = function (cat_id, desc, elem_id, done) {
    var tableName = "codes";
    var argNames = ["category_id", "description", "element_id"];
    var values = [[cat_id], [desc], [elem_id]];
    var createdSQL = SQLHelper.createSQLInsertString(tableName, argNames, values);
    db.get().query(createdSQL['SQLQueryString'], createdSQL['SQLQueryValues'], function (err, result) {
        if (err) return done(err);
        done(null, result.insertId);
    })
};