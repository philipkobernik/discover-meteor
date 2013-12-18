root = exports ? this
root.Posts = new Meteor.Collection 'posts'

Meteor.methods
  post: (postAttributes)->
    user = Meteor.user()
    postWithSameLink = Posts.findOne url: postAttributes.url

    unless user
      throw new Meteor.Error 401, 'You need to login to post new stories'

    unless postAttributes.title
      throw new Meteor.Error 422, 'Please fill in a headline'

    if postAttributes.url && postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted', postWithSameLink._id

    post = _.extend(_.pick(postAttributes, 'url', 'title', 'message'),
      title: "#{postAttributes.title} #{ if @isSimulation then '(CLIENT)' else '(SERVER)'}"
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    )

    unless @isSimulation
      Future = Npm.require 'fibers/future'
      future = new Future()
      Meteor.setTimeout ->
        future.return()
      , 5*1000

      future.wait()

    postId = Posts.insert post

    postId

