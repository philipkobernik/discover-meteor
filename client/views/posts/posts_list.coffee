Template.postsList.helpers
  hasMorePosts: ->
    currentLimit = Router.current().limit()
    subscriptionPosts = @posts.count()
    #console.log "currentLimit: #{currentLimit}, subscriptionPosts: #{subscriptionPosts}"
    currentLimit is subscriptionPosts
