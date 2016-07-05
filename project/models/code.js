var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');

exports.createExplicit = function (code, cat_id, desc, elem_id, done) {
    var tableName = "codes";
    var argNames = ["code", "category_id", "description", "element_id"];
    var values = [[code], [cat_id], [desc], [elem_id]];
    var createdSQL = SQLHelper.createSQLInsertString(tableName, argNames, values);
    //console.log("input arguments are " + JSON.stringify(arguments));
    //console.log("created SQL is " + JSON.stringify(createdSQL));
    db.get().query(createdSQL['SQLQueryString'], createdSQL['SQLQueryValues'], function (err, result) {
        if (err) return done(err);
        //console.log("create explicit db result is " + JSON.stringify(result));
        done(null, result.insertId);
    });
};

exports.create = function (cat_id, desc, elem_id, done) {
    var values = [cat_id, desc, elem_id];
    var createdSQLString = "CALL addcode(?, ?, ?)";
    db.get().query(createdSQLString, values, function (err, result) {
        console.log("create code db result is " + JSON.stringify(result));
        if (err) return done(err);
        done(null, result[0][0]['newcode']);
    });
};

exports.getForDisplay = function (id, done) {
    var whereClause = "";
    if (id && !isNaN(id)) {//qualifies if id != "" and id!=null and id is a number
        whereClause = "WHERE codes.id = " + id + " ";
    }
    var sql = "SELECT codes.id ,codes.code, codes.time, codes.description, codes.is_cancelled, cats.name AS category, elems.name AS element, GROUP_CONCAT(DISTINCT CONCAT(oc.name, ' ', oc.code) SEPARATOR ', ') AS othercodes, GROUP_CONCAT(DISTINCT crs.name SEPARATOR ', ') AS requestedby, times.time AS codetime FROM codes LEFT OUTER JOIN (SELECT optional_codes.id, optional_codes.code_id, optional_codes.code, rldcs.name FROM optional_codes INNER JOIN rldcs ON rldcs.id = optional_codes.rldc_id) AS oc ON codes.id = oc.code_id LEFT OUTER JOIN (SELECT code_requests.code_id, entities.name FROM code_requests INNER JOIN entities ON code_requests.entity_id = entities.id) AS crs ON codes.id = crs.code_id LEFT OUTER JOIN categories AS cats ON codes.category_id = cats.id LEFT OUTER JOIN elements AS elems ON codes.element_id = elems.id LEFT OUTER JOIN times ON codes.id = times.code_id " + whereClause + "GROUP BY codes.id ORDER BY codes.time DESC";
    //console.log("sql for get single is " + sql);
    db.get().query(sql, function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    });
};