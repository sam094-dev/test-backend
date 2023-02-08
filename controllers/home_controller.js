const Post = require('../models/post');
const { populate } = require('../models/user');


module.exports.home = function(req, res) {
    // console.log(req.cookies);
    // res.cookie('user_id', 25);
    // Post.find({}, function(err, userspost) {
    //     return res.render('home', {
    //         title: "Home",
    //         posts: userspost
    //     });
    // })




    //populate the user of each post
    Post.find({}).populate('user').exec(function(err, userspost) {
        return res.render('home', {
            title: "Home",
            posts: userspost
        });
    });
}



// module.exports.actionName = function(req, res){}