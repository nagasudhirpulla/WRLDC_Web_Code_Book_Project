var db = require('./project/db');
var express = require('express');
var morgan = require('morgan');
var bodyParser = require('body-parser');
var cors = require('./project/cors');
var favicon = require('serve-favicon');

var app = express();
var port = process.env.PORT || 3000;

app.use(cors());

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());


app.use(express.static(__dirname + '/project/views'));
app.set('views', __dirname + '/project/views');
app.set('view engine', 'ejs');

app.use(morgan('dev'));

app.set('json spaces', 1);

app.use(favicon(__dirname + '/project/public/img/favicon.ico'));

app.use('/api/categories', require('./project/controllers/category'));
app.use('/api/rldcs', require('./project/controllers/rldc'));
app.use('/api/entities', require('./project/controllers/entity'));
app.use('/api/regions', require('./project/controllers/region'));
app.use('/api/associates', require('./project/controllers/associate'));
app.use('/api/codes', require('./project/controllers/code'));
app.use('/api/optional_codes', require('./project/controllers/optional_code'));
app.use('/api/code_requests', require('./project/controllers/code_request'));
app.use('/', require('./project/controllers/general'));


// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});

// Connect to MySQL on start
db.connect(db.MODE_PRODUCTION, function (err) {
    if (err) {
        console.log('Unable to connect to the Scheduling Database.');
        process.exit(1);
    } else {
        app.listen(port, function () {
            console.log('Listening on port ' + port + ' ...');
        })
    }
});