########################################
# schema
########################################
###
keyword =
  text:       ''    # 키워드
  hits:       ''    # 사용횟수
  createdAt:  Date  # 생성일시
###
@Keyword = new Mongo.Collection 'keyword'
if Meteor.isServer
  Keyword._ensureIndex({text:1})
  Keyword._ensureIndex({hits:1})

########################################
# allow / deny
########################################
if Meteor.isServer
  Keyword.allow
    insert: -> return false
    update: -> return false
    remove: -> return false

########################################
# publish
########################################
#if Meteor.isServer
#  Meteor.publish 'keyword', ->
#    return Keyword.find()

########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#    getTop50: ()->
#      qry = {}
#      return Feed.find(qry)