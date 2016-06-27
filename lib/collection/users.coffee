########################################
# schema
########################################
###
users =
  username:       '' # 아이디
  email:          '' # 이메일
  service:        ''
    password:     '' # 패스워드
    facebook:     {} # 페이스북 로그인 정보
    kakao:        {} # 카카오톡 로그인 정보
  profile:        ''
    name:         '' 사용자 이름
    bio:          '' 자기소개
    mobileNo:     '' 휴대번호
    zipcode:      '' 우편번호
    address1:     '' 주소
    address2:     '' 상세주소
    allowPush:    '' 푸시 수신 여부
    allowEmail:   '' 이메일 수신 여부
    allowSms:     '' SMS 수신 여부
    status:       '' ACTIVE | UNREGISTER | BAN | LOCK | WAIT_FOR_PASSWORD
###

########################################
# init
########################################
if Meteor.isServer
  Accounts.onCreateUser (options, user) ->
    # override profile
    options.profile.status = 'ACTIVE'

    if options.profile?
      user.profile = options.profile
    return user

########################################
# method
########################################
#if Meteor.isServer
#  SSR.compileTemplate 'findUserOtpEmail',      Assets.getText('ssr/findUserOtpEmail.html')
#  SSR.compileTemplate 'unregisterMemberEmail', Assets.getText('ssr/unregisterMemberEmail.html')
#  SSR.compileTemplate 'updateProfileEmail',    Assets.getText('ssr/updateProfileEmail.html')
#
#  Meteor.methods
#    changeEmail: (email)->
#      unless Meteor.userId() then throw new Meteor.Error ERR.LOGIN_REQUIRED
#      return Meteor.users.update( Meteor.userId(), {$set: {'emails.0.address': email}} )
#
#  Meteor.methods
#    updateProfile: (userId, profile)->
#      unless userId then throw new Meteor.Error ERR.LOGIN_REQUIRED
#      return Meteor.users.update( userId, {$set: {profile: profile}} )
#
#  Meteor.methods
#    validateUserWithCell: (name, cell)->
#      return true
#
#  Meteor.methods
#    validateUserWithEmail: (name, email)->
#      unless name or email then throw new Meteor.Error ERR.INVALID_NAME_OR_EMAIL
#      user = Accounts.findUserByEmail(email)
#      unless user then return false
#      unless user.profile.userName is name then return false
#
#      data = {}
#      data.userEmail    = email
#      data.otpCode      = makeOtp()
#      data.otpCreatedAt = new Date()
#      data.asset_url    = Meteor.settings.SSR_ASSET_URL
#      data.adminEmail   = Meteor.settings.ADMIN_EMAIL
#
#      # set otp
#      Meteor.users.update user._id,
#        $set:
#          'profile.otp':          data.otpCode
#          'profile.otpCreatedAt': data.otpCreatedAt
#
#      Email.send
#        to:     data.userEmail
#        from:   data.adminEmail
#        subject:'레드프린팅 앤 프레스 인증번호 [' + data.otpCode + ']'
#        html:   SSR.render('findUserOtpEmail', data)
#      return true
#
#  Meteor.methods
#    emailForUnregister:(email)->
#      unless email then throw new Meteor.Error ERR.INVALID_NAME_OR_EMAIL
#
#      data = {}
#      data.userEmail    = email
#      data.asset_url    = Meteor.settings.SSR_ASSET_URL
#      data.adminEmail   = Meteor.settings.ADMIN_EMAIL
#
#      Email.send
#        to:     data.userEmail
#        from:   data.adminEmail
#        subject:'레드프린팅 회원탈퇴 완료'
#        html:   SSR.render('unregisterMemberEmail', data)
#      return true
#
#  Meteor.methods
#    emailForUpdateProfile:(email)->
#      unless email then throw new Meteor.Error ERR.INVALID_NAME_OR_EMAIL
#
#      data = {}
#      data.userEmail    = email
#      data.asset_url    = Meteor.settings.SSR_ASSET_URL
#      data.adminEmail   = Meteor.settings.ADMIN_EMAIL
#
#      Email.send
#        to:     data.userEmail
#        from:   data.adminEmail
#        subject:'레드프린팅 회원정보 수정 완료'
#        html:   SSR.render('updateProfileEmail', data)
#      return true
#
#  Meteor.methods
#    authUserWithEmail: (name, email, otp)->
#      unless name or email or otp then throw new Meteor.Error ERR.INVALID_NAME_OR_EMAIL
#      user = Accounts.findUserByEmail(email)
#      unless user or user.profile.otp then return null
#      unless user.profile.userName is name then return null
#
#      currentTime = moment(new Date())
#      otpTime     = moment(user.profile.otpCreatedAt)
#      durationTime = currentTime.diff(otpTime, 'seconds')
#
#      unless durationTime < 60 then throw new Meteor.Error ERR.OTP_TIMEOUT
#
#      if user.profile.otp is otp then return user.username
#      else return null
#
#  Meteor.methods
#    unregisterMember: (digest)->
#      unless Meteor.userId() then throw new Meteor.Error ERR.LOGIN_REQUIRED
#      user = Meteor.user()
#      password = {digest: digest, algorithm: 'sha-256'}
#      result = Accounts._checkPassword(user, password)
#      if result?.error then throw result.error
#
#      # mark register member
#      profile = Meteor.user().profile
#      profile.status = 'UNREGISTER'
#      Meteor.users.update( Meteor.userId(), {$set: {profile: profile}} )
#
#      # release own resource
#      qry = {userId: Meteor.userId()}
#      Addressbook.remove(qry)
#      Cart.remove(qry)
#      return
#
#  Meteor.methods
#    getUserStatus: (userId)->
#      unless userId then throw new Meteor.Error ERR.USER_ID_REQUIRED
#      user = Meteor.users.findOne({username: userId})
#      unless user then throw new Meteor.Error ERR.USER_NOT_FOUND
#      return user.profile.status
