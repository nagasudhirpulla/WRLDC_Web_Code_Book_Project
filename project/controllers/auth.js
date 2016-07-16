var express = require('express');
var router = express.Router();
var passport = require('../config/passport').get();

router.get('/login', function (req, res) {
    if (req.isAuthenticated()) {
        res.redirect('/');
    }
    res.render('login.ejs', {message: req.flash('loginMessage')});
});

router.post('/login', passport.authenticate('local-login', {
    successRedirect: '/',
    failureRedirect: '/login',
    failureFlash: true
}));

router.get('/signup', function (req, res) {
    res.render('signup.ejs', {message: req.flash('signupMessage')});
});

router.post('/signup', passport.authenticate('local-signup', {
    successRedirect: '/',
    failureRedirect: '/signup',
    failureFlash: true
}));

router.get('/logout', function (req, res) {
    req.logout();
    res.redirect('/');
});

router.post('/', function (req, res, next) {
    console.log("reached auth post...");
    //catch any post requests here
    isLoggedIn(req, res, next);
});

function isLoggedIn(req, res, next) {
    console.log("reached isLoggedIn...");
    if (req.isAuthenticated()) {
        return next();
    }
    res.redirect('/login');
}

module.exports = router;