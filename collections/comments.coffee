root = exports ? this

root.Comments = new Meteor.Collection 'comments'

Meteor.methods
  comment: (commentAttributes)->
    user = Meteor.user()
    post = Posts.findOne commentAttributes.postId

    unless user? # ensure logged in
      throw new Meteor.Error 401, 'You need to login to make comments'

    unless commentAttributes.body?
      throw new Meteor.Error 422, 'Please write a comment'

    unless post
      throw new Meteor.Error 244, 'You must comment on a post'

    comment = _.extend(_.pick(commentAttributes, 'postId', 'body'),
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    )

    Posts.update comment.postId, {$inc: {commentsCount: 1}}

    comment._id = Comments.insert comment

    createCommentNotification comment

    return comment._id

