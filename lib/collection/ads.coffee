########################################
# schema
########################################
###
ads =
  _id:              ''        # 광고 id
  clientId:         ''        # 광고주 id
  title:            ''        # 광고제목
  imageUrl:         ''        # 메인이미지 URL
  contentUrl:       ''        # 상세 내용 URL (링크가 있는경우)
  startDatetime:    Date      # 광고 시작 일시
  endDatetime:      Date      # 광고 종료 일시
  status:           ''        # 상태값 OPEN | CLOSED | READY | EXPIRED 등등..
  views:            0         # 노출횟수
  tagList:          ['', ...] # 태그
  createdAt:        Date      # 생성일시
###
@Ads = new Mongo.Collection 'ads'
if Meteor.isServer
  Ads._ensureIndex({itemCode:1})
  Ads._ensureIndex({clientCode:1})
  Ads._ensureIndex({title:1})
  Ads._ensureIndex({startDatetime:1})
  Ads._ensureIndex({endDatetime:1})
  Ads._ensureIndex({status:1})
  Ads._ensureIndex({views:1})
  Ads._ensureIndex({tag:1})

########################################
# allow / deny
########################################
if Meteor.isServer
  Ads.allow
    insert: -> return false
    update: -> return false
    remove: -> return false

########################################
# publish
########################################
#if Meteor.isServer
#  Meteor.publish 'ads', ->
#    return Ads.find()

########################################
# method
########################################
#if Meteor.isServer
#  Meteor.methods
#   'getAd': ->
#     return {}