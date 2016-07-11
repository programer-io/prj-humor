########################################
# schema
########################################
###
adClient =
  _id:            ''    # 광고주 id
  name:           ''    # 광고주 이름
  authPassword:   ''    # 광고주 비밀번호
  bizRegCode:     ''    # 사업자 등록번호
  createdAt:      Date  # 생성일시
###
@AdClient = new Mongo.Collection 'adClient'
if Meteor.isServer
  AdClient._ensureIndex({clientCode:1})
  AdClient._ensureIndex({name:1})
  AdClient._ensureIndex({bizRegCode:1})

########################################
# allow / deny
########################################
if Meteor.isServer
  AdClient.allow
    insert: -> return false
    update: -> return false
    remove: -> return false

########################################
# publish
########################################
#if Meteor.isServer
#  Meteor.publish 'adClient', ->
#    return AdClient.find()

########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#   'getClient': ->
#     return {}