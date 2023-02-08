const passport = require('passport');
const User = require('../models/user')

const LocalStratgy = require('passport-local').Strategy;

passport.use(new LocalStratgy({
        usernameField: 'email' //usernamefield is , on that basis i want to find user
    },
    function(email, password, done) { // callback function
        // find the user and establish the identity
        User.findOne({ email: email }, function(err, user) {
            if (err) {
                console.log("error in finding the user---> passport");
                // done have two argument 
                // 1)  Error
                // 2) Authentication
                // can be run on a single argument
                return done(err);
            }

            if (!user || user.password != password) {
                console.log("Invalid user name/ Password", user.password, " ", password);
                return done(null, false);
            }
            return done(null, user);
        })

    }

));


// serializing the user to decide which key is to be kept in the cookie
passport.serializeUser(function(user, done) {
    done(null, user.id);
});




// deserializing the user fron the user key in the cookie
passport.deserializeUser(function(id, done) {
    User.findById(id, function(err, user) {
        if (err) {
            console.log("error in finding the user---> passport");
            return done(err);
        }
        return done(null, user.id);
    });


});


// will act as a middleware


// check if the user is authenticated
passport.checkAuthentication = function(req, res, next) {
    // if the user is signed in, then pass on the request to the next function(controller's action)
    if (req.isAuthenticated()) {
        return next();
    }
    // if the user is not signed in
    return res.redirect('/users/sign-in');
}

passport.setAuthenticatedUser = function(req, res, next) {
    if (req.isAuthenticated()) {
        // request.user contains the current sugned in user from the session cookie ans we are just sending it to locals for view;
        res.locals.user = req.user;
    }
    next();
}

module.exports = passport;