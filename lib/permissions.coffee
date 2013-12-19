root = exports ? this

root.ownsDocument = (userId, doc)->
  doc? and doc.userId is userId
