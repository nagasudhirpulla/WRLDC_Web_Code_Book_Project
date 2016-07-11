var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.create = function (entity_ids, code_ids, done) {
    var tableName = "code_requests";
    var argNames = ["entity_id", "code_id"];
    var values = [entity_ids, code_ids];
    var createdSQL = SQLHelper.createSQLInsertString(tableName, argNames, values);
    console.log("other codes insert query is " + JSON.stringify(createdSQL));
    db.get().query(createdSQL['SQLQueryString'], createdSQL['SQLQueryValues'], function (err, result) {
        if (err) return done(err);
        done(null, result.affectedRows);
    });
};