warning: in the working copy of 'controllers/home_controller.js', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'index.js', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'routes/index.js', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'views/home.ejs', LF will be replaced by CRLF the next time Git touches it
[1mdiff --git a/controllers/home_controller.js b/controllers/home_controller.js[m
[1mindex a838ce3..9b499de 100644[m
[1m--- a/controllers/home_controller.js[m
[1m+++ b/controllers/home_controller.js[m
[36m@@ -1,9 +1,29 @@[m
[32m+[m[32mconst Post = require('../models/post');[m
[32m+[m[32mconst { populate } = require('../models/user');[m
[32m+[m
[32m+[m
 module.exports.home = function(req, res) {[m
[31m-    console.log(req.cookies);[m
[31m-    res.cookie('user_id', 25);[m
[31m-    return res.render('home', {[m
[31m-        title: "Home"[m
[32m+[m[32m    // console.log(req.cookies);[m
[32m+[m[32m    // res.cookie('user_id', 25);[m
[32m+[m[32m    // Post.find({}, function(err, userspost) {[m
[32m+[m[32m    //     return res.render('home', {[m
[32m+[m[32m    //         title: "Home",[m
[32m+[m[32m    //         posts: userspost[m
[32m+[m[32m    //     });[m
[32m+[m[32m    // })[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    //populate the user of each post[m
[32m+[m[32m    Post.find({}).populate('user').exec(function(err, userspost) {[m
[32m+[m[32m        return res.render('home', {[m
[32m+[m[32m            title: "Home",[m
[32m+[m[32m            posts: userspost[m
[32m+[m[32m        });[m
     });[m
 }[m
 [m
[32m+[m
[32m+[m
 // module.exports.actionName = function(req, res){}[m
\ No newline at end of file[m
[1mdiff --git a/models/post.js b/models/post.js[m
[1mindex f104cbe..97d38af 100644[m
[1m--- a/models/post.js[m
[1m+++ b/models/post.js[m
[36m@@ -1,14 +1,19 @@[m
 const mongoose = require('mongoose');[m
 [m
[32m+[m
 const postSchema = new mongoose.Schema({[m
     content: {[m
         type: String,[m
         required: true[m
     },[m
     user: {[m
[31m-        type: mongoose.Schema.Types.ObjectId, // refer to the user schema[m
[31m-        ref: 'User' // refer to which schema[m
[32m+[m[32m        type: mongoose.Schema.Types.ObjectId,[m
[32m+[m[32m        ref: 'User'[m
[32m+[m
     }[m
 }, {[m
     timestamps: true[m
[31m-})[m
\ No newline at end of file[m
[32m+[m[32m});[m
[32m+[m
[32m+[m[32mconst Post = mongoose.model('Post', postSchema);[m
[32m+[m[32mmodule.exports = Post;[m
\ No newline at end of file[m
[1mdiff --git a/routes/index.js b/routes/index.js[m
[1mindex 6682e65..5e62926 100644[m
[1m--- a/routes/index.js[m
[1m+++ b/routes/index.js[m
[36m@@ -8,6 +8,7 @@[m [mconsole.log('router loaded');[m
 [m
 router.get('/', homeController.home);[m
 router.use('/users', require('./users'));[m
[32m+[m[32mrouter.use('/posts', require('./posts'));[m
 [m
 // for any further routes, access from here[m
 // router.use('/routerName', require('./routerfile));[m
[1mdiff --git a/views/home.ejs b/views/home.ejs[m
[1mindex 8741dec..6c15fad 100644[m
[1m--- a/views/home.ejs[m
[1m+++ b/views/home.ejs[m
[36m@@ -2,11 +2,25 @@[m
     Codeial /[m
     <%= title %>[m
 </h1>[m
[32m+[m
[32m+[m
 <section id="feed-posts">[m
     <h4>Posts</h4>[m
[31m-    <form action="" id="new-post-form" method="POST">[m
[31m-        <textarea name="content" cols="30" rows="3" placeholder="Type Here"></textarea>[m
[32m+[m[32m    <form action="/posts/create" id="new-post-form" method="POST">[m
[32m+[m[32m        <textarea name="content" cols="30" rows="3" placeholder="Type Here..."></textarea>[m
         <input type="submit" value="Post">[m
     </form>[m
[32m+[m[32m    <div id="posts-list-container">[m
[32m+[m[32m        <ul>[m
[32m+[m[32m            <% for(post of posts) { %>[m
[32m+[m[32m                <li>[m
[32m+[m[32m                    <%=post.content%>[m
[32m+[m[32m                        <small>[m
[32m+[m[32m                            <%=post.user %>[m
[32m+[m[32m                        </small>[m
[32m+[m[32m                </li>[m
[32m+[m[32m                <% } %>[m
 [m
[32m+[m[32m        </ul>[m
[32m+[m[32m    </div>[m
 </section>[m
\ No newline at end of file[m
