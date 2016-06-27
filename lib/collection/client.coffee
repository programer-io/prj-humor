########################################
# schema
########################################
###
client =
  _id:            ''    # 광고주 id
  name:           ''    # 광고주 이름
  authPassword:   ''    # 광고주 비밀번호
  bizRegCode:     ''    # 사업자 등록번호
  createdAt:      Date  # 생성일시
###
@Client = new Mongo.Collection 'client'
if Meteor.isServer
  Client._ensureIndex({clientCode:1})
  Ads._ensureIndex({name:1})
  Ads._ensureIndex({bizRegCode:1})

########################################
# allow / deny
########################################
if Meteor.isServer
  Client.allow
    insert: -> return false
    update: -> return false
    remove: -> return false

########################################
# publish
########################################
#if Meteor.isServer
#  Meteor.publish 'client', ->
#    return Client.find()

########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#   'getClient': ->
#     return {}