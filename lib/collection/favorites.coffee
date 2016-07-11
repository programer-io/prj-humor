########################################
# schema
########################################
###
favorites =
  _id:        ''   # 찜하기 id
  userId:     ''   # 수집기 아이디
  feedId:     ''   # feedId
  createdAt:  Date # favorites 생성일시
###
@Favorites = new Mongo.Collection 'favorites'
if Meteor.isServer
  Favorites._ensureIndex({userId:1})
  Favorites._ensureIndex({createdAt:1})


########################################
# allow / deny
########################################
if Meteor.isServer
  Favorites.allow
    insert: -> return false
    update: -> return false
    remove: -> return false


########################################
# publish
########################################
if Meteor.isServer
  Meteor.publish 'favorites', ->
    return Favorites.find()


########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#    getFavorites: ()->
#      qry = {}
#      return Favorites.find(qry)