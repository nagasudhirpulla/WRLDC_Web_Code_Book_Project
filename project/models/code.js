var db = require('../db.js');
var SQLHelper = require('../helpers/sqlHelper');
var DateHelper = require('../helpers/date.js');
var ArrayHelper = require('../helpers/arrayHelper.js');

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
        //console.log("create code db result is " + JSON.stringify(result));
        if (err) return done(err);
        done(null, result[0][0]['newcode']);
    });
};

exports.getForDisplay = function (id, done, offset) {
    var whereClause = "";
    var LimitClause = "LIMIT 100";
    if (id && !isNaN(id)) {//qualifies if id != "" and id!=null and id is a number
        whereClause = "WHERE codes.id = " + id + " ";
    }
    if (offset && !isNaN(Number(offset))) {//qualifies if id != "" and id!=null and id is a number
        LimitClause = "LIMIT " + Number(offset) + ",100";
    }
    var sql = "SELECT codes.id ,codes.code, codes.time, codes.description, codes.is_cancelled, cats.name AS category, elems.name AS element, GROUP_CONCAT(DISTINCT CONCAT(oc.name, ' ', oc.code) SEPARATOR ', ') AS othercodes, GROUP_CONCAT(DISTINCT crs.name SEPARATOR ', ') AS requestedby, times.time AS codetime FROM codes LEFT OUTER JOIN (SELECT optional_codes.id, optional_codes.code_id, optional_codes.code, rldcs.name FROM optional_codes INNER JOIN rldcs ON rldcs.id = optional_codes.rldc_id) AS oc ON codes.id = oc.code_id LEFT OUTER JOIN (SELECT code_requests.code_id, entities.name FROM code_requests INNER JOIN entities ON code_requests.entity_id = entities.id) AS crs ON codes.id = crs.code_id LEFT OUTER JOIN categories AS cats ON codes.category_id = cats.id LEFT OUTER JOIN elements AS elems ON codes.element_id = elems.id LEFT OUTER JOIN times ON codes.id = times.code_id " + whereClause + "GROUP BY codes.id ORDER BY codes.time DESC " + LimitClause;
    //console.log("sql for get single is " + sql);
    db.get().query(sql, function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    });
};

exports.getCount = function (done) {
    var sql = "SELECT COUNT(*) AS count FROM codes;";
    //console.log("sql for get single is " + sql);
    db.get().query(sql, function (err, result) {
        if (err) return done(err);
        //console.log("get code count result is "+JSON.stringify(result));
        done(null, result[0]['count']);
    });
};

exports.getForEdit = function (id, done) {
    var whereClause = "";
    if (id && !isNaN(id)) {//qualifies if id != "" and id!=null and id is a number
        whereClause = "WHERE codes.id = " + id + " ";
    }
    var sql = "SELECT codes.id ,codes.code, codes.time, codes.description, codes.is_cancelled, cats.name AS category, cats.id AS categoryId, elems.name AS element, elems.id AS elementId, GROUP_CONCAT(DISTINCT CONCAT(oc.name, ' ', oc.code) SEPARATOR ', ') AS othercodes, GROUP_CONCAT(DISTINCT crs.id SEPARATOR ', ') AS requestedbyIds, GROUP_CONCAT(DISTINCT crs.name SEPARATOR ', ') AS requestedby, times.time AS codetime FROM codes LEFT OUTER JOIN (SELECT optional_codes.id, optional_codes.code_id, optional_codes.code, rldcs.name FROM optional_codes INNER JOIN rldcs ON rldcs.id = optional_codes.rldc_id) AS oc ON codes.id = oc.code_id LEFT OUTER JOIN (SELECT code_requests.code_id, entities.name, entities.id FROM code_requests INNER JOIN entities ON code_requests.entity_id = entities.id) AS crs ON codes.id = crs.code_id LEFT OUTER JOIN categories AS cats ON codes.category_id = cats.id LEFT OUTER JOIN elements AS elems ON codes.element_id = elems.id LEFT OUTER JOIN times ON codes.id = times.code_id " + whereClause + "GROUP BY codes.id ORDER BY codes.time DESC";
    //console.log("sql for get single is " + sql);
    db.get().query(sql, function (err, rows) {
        if (err) return done(err);
        done(null, rows);
    });
};

exports.getByFilter = function (searchTxt, searchDate, offset, done) {
    var whereClause = "";
    var LimitClause = "LIMIT 100";
    if (offset && !isNaN(Number(offset))) {//qualifies if id != "" and id!=null and id is a number
        LimitClause = "LIMIT " + Number(offset) + ",100";
    }
    if (searchTxt && searchTxt != 'null' && searchTxt.trim() != '') {
        whereClause = "WHERE (id = '" + searchTxt + "' OR description LIKE '%" + searchTxt + "%' OR element LIKE '%" + searchTxt + "%' OR othercodes LIKE '%" + searchTxt + "%' OR requestedby LIKE '%" + searchTxt + "%') ";
    }
    var searchDateObj = new Date(searchDate);
    if (searchDate && searchDate.trim() != "" && searchDate != 'null' && DateHelper.isDateObjectValid(searchDateObj)) {
        var dateSearchClause = "time between '" + DateHelper.getDateString(searchDateObj) + " 00:00:00' AND '" + DateHelper.getDateString(searchDateObj) + " 23:59:59' ";
        if (whereClause != '') {
            whereClause += "AND " + dateSearchClause;
        } else {
            whereClause = "WHERE " + dateSearchClause;
        }
    }
    var sql = "SELECT * FROM (SELECT codes.id ,codes.code, codes.time, codes.description, codes.is_cancelled, cats.name AS category, elems.name AS element, GROUP_CONCAT(DISTINCT CONCAT(oc.name, ' ', oc.code) SEPARATOR ', ') AS othercodes, GROUP_CONCAT(DISTINCT crs.name SEPARATOR ', ') AS requestedby, times.time AS codetime FROM codes LEFT OUTER JOIN (SELECT optional_codes.id, optional_codes.code_id, optional_codes.code, rldcs.name FROM optional_codes INNER JOIN rldcs ON rldcs.id = optional_codes.rldc_id) AS oc ON codes.id = oc.code_id LEFT OUTER JOIN (SELECT code_requests.code_id, entities.name FROM code_requests INNER JOIN entities ON code_requests.entity_id = entities.id) AS crs ON codes.id = crs.code_id LEFT OUTER JOIN categories AS cats ON codes.category_id = cats.id LEFT OUTER JOIN elements AS elems ON codes.element_id = elems.id LEFT OUTER JOIN times ON codes.id = times.code_id GROUP BY codes.id ORDER BY codes.time DESC) AS display_table " + whereClause + LimitClause;
    //console.log("sql for filter get is " + sql);
    db.get().query(sql, function (err, rows) {
        if (err) return done(err);
        //console.log("The get_by_filter db query result is " + JSON.stringify(rows));
        done(null, rows);
    });
};

exports.update = function (record_id, is_cancelled, rldc_ids, rldc_codes, cat, elemId, entity_ids, desc, code_time, done) {
    var SQLString = "START TRANSACTION READ WRITE;UPDATE codes SET category_id=?,description=?,element_id=?,is_cancelled=? WHERE id=?;";
    var values = [cat, desc, elemId, is_cancelled, record_id];
    if (rldc_ids && rldc_ids.length > 0 && rldc_ids.length == rldc_codes.length) {
        if (!(rldc_ids.constructor === Array)) {
            rldc_codes = [[rldc_codes]];
            rldc_ids = [[rldc_ids]];
        }
        //include rldc ids update code
        SQLString += "DELETE FROM optional_codes WHERE code_id=?;";
        values = values.concat(record_id);
        var rldc_codes_SQL = SQLHelper.createSQLInsertString("optional_codes", ["code_id", "rldc_id", "code"], [ArrayHelper.createArrayFromSingleElement(record_id, rldc_ids.length), rldc_ids, rldc_codes]);
        SQLString += rldc_codes_SQL['SQLQueryString'];
        values = values.concat(rldc_codes_SQL['SQLQueryValues']);
    }
    if (DateHelper.isDateObjectValid(new Date(code_time)) && code_time != "" && code_time != null && code_time != "null") {
        //we have a valid datetime to update
        var code_time_value = DateHelper.getDateTimeString(new Date(code_time));
        SQLString += "DELETE FROM times WHERE code_id = ?;";
        values = values.concat(record_id);
        var code_time_SQL = SQLHelper.createSQLInsertString("times", ["code_id", "time"], [[record_id], [code_time_value]]);
        SQLString += code_time_SQL['SQLQueryString'];
        values = values.concat(code_time_SQL['SQLQueryValues']);
    }
    if (entity_ids && entity_ids.length > 0) {
        if (!(entity_ids.constructor === Array)) {
            entity_ids = [[entity_ids]];
        }
        //we have to update the requesting entity ids list
        SQLString += "DELETE FROM code_requests WHERE code_id=?;";
        values = values.concat(record_id);
        var req_entities_SQL = SQLHelper.createSQLInsertString("code_requests", ["code_id", "entity_id"], [ArrayHelper.createArrayFromSingleElement(record_id, entity_ids.length), entity_ids]);
        SQLString += req_entities_SQL['SQLQueryString'];
        values = values.concat(req_entities_SQL['SQLQueryValues']);
    }
    SQLString += "COMMIT;";
    //console.log("The code update SQL is " + SQLString + "\n");
    //console.log("The code update SQL values are " + values + "\n");
    db.get().query(SQLString, values, function (err, result) {
        if (err) return done(err);
        done(null, result);
    });
};