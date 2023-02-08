const express = require('express');
const cookieParser = require('cookie-parser');
const app = express();
const port = 8010;
const bodyParser = require('body-parser')
const expressLayouts = require('express-ejs-layouts');
const db = require('./config/mongoose');
//const { session } = require('passport');
const session = require('express-session');
const passport = require('passport');
const passportLocal = require('./config/passport-local-stratgy');
//const { connection } = require('mongoose');
const MongoStore = require('connect-mongo')(session);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(express.static('./assets'));

app.use(expressLayouts);
// extract style and scripts from sub pages into the layout
app.set('layout extractStyles', true);
app.set('layout extractScripts', true);




// set up the view engine
app.set('view engine', 'ejs');
app.set('views', './views');

//mongo store is used to store the session cookie in db
app.use(session({
    name: 'codial',
    // TODO change the secret before the deployment in production mode
    secret: 'anything',
    saveUninitialized: false,
    resave: false,
    cookie: {
        maxAge: (1000 * 60 * 100) // in term of milisecond
    },
    store: new MongoStore({
            mongooseConnection: db,
            autoRemove: 'disable'
        },
        function(err) {
            console.log(err || 'connect- mongodb setup ok');
        }
    )

}));
app.use(passport.initialize());
app.use(passport.session());
app.use(passport.setAuthenticatedUser);

// use express router
app.use('/', require('./routes'));


app.listen(port, function(err) {
    if (err) {
        console.log(`Error in running the server: ${err}`);
    }

    console.log(`Server is running on port: ${port}`);
});