Template.postsList.helpers
  hasMorePosts: ->
    return false unless Router.current().limit?
    currentLimit = Router.current().limit()
    subscriptionPosts = @posts.count()
    #console.log "currentLimit: #{currentLimit}, subscriptionPosts: #{subscriptionPosts}"
    currentLimit is subscriptionPosts
