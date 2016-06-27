var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.create = function (code_ids, rldc_ids, codes, done) {
    var tableName = "optional_codes";
    var argNames = ["code_id", "rldc_id", "code"];
    var values = [code_ids, rldc_ids, codes];
    var createdSQL = SQLHelper.createSQLInsertString(tableName, argNames, values);
    console.log("SQL String for other rldc codes creation " + createdSQL['SQLQueryString']);
    console.log("SQL values for other rldc codes creation " + createdSQL['SQLQueryValues']);
    db.get().query(createdSQL['SQLQueryString'], createdSQL['SQLQueryValues'], function (err, result) {
        if (err) return done(err);
        done(null, result.affectedRows);
    })
};