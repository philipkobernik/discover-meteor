root = exports ? this
root.Posts = new Meteor.Collection 'posts'

Posts.allow(
  insert: (userId, doc)->
    # only allow posting if you are logged in
    return userId?
)
