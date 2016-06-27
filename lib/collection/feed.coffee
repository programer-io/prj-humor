########################################
# schema
########################################
###
feed =
  _id:          '' # 피드 id
  crawlerId:    '' # 수집기 아이디
  providerCode: '' # 컨텐츠 제공자 코드 (DAUM, NAVER, YOUTUBE, 등)
  title:        '' # 제목
  imageUrl:     '' # 대표이미지 URL
  contentUrl:   '' # 상세내용 URL
  contentType:  '' # 콘텐츠 종류 (TEXT, IMAGE, VIDEO 등)
  tagList:      '' # 관련 태그
  reads:        '' # 읽은 횟수
  createdAt:  Date # 생성일시
###
@Feed = new Mongo.Collection 'feed'
if Meteor.isServer 
  Feed._ensureIndex({title:1})
  Feed._ensureIndex({contentType:1})
  Feed._ensureIndex({tagList:1})
  Feed._ensureIndex({reads:1})


########################################
# allow / deny
########################################
if Meteor.isServer
  Feed.allow
    insert: -> return false
    update: -> return false
    remove: -> return false


########################################
# publish
########################################
if Meteor.isServer
  Meteor.publish 'feed', ->
    return Feed.find()


########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#    getHotFeed: ()->
#      qry = {}
#      return Feed.find(qry)