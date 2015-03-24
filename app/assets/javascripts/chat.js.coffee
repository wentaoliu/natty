$(document).on 'ready page:load', ->

  # 设置聊天框尺寸
  tab = $('.chat .tab.segment')
  tab.height ->
    padding = parseFloat $('.chat .sixteen.wide.column').css('padding-top')
    $(window).height() - tab.offset().top - $('#say').height() - padding * 4

  if false

    server = 'http://localhost:3001'
    socket = io.connect server

    from = $.cookie 'remember_token'  #从 cookie 中读取用户名，存于变量 from
    to = 'all'  #设置默认接收对象为"所有人"

    #刷新用户在线列表
    flushUsers = (users) ->
      #清空之前用户列表
      list = $ '.chat .divided.list'
      list.empty
      #遍历生成用户在线列表
      for token, user of users
        list.append """
          <div class="item">
            <img class="ui avatar image" src="/images/avatar/small/justen.jpg">
            <div class="content">
              <div class="header">#{user.name}</div>
            </div>
          </div>"""

    #获取当前时间
    now = ->
      date = new Date
      date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate() + ' ' + date.getHours() + ':' + (if date.getMinutes() < 10 then '0' + date.getMinutes() else date.getMinutes()) + ':' + (if date.getSeconds() < 10 then '0' + date.getSeconds() else date.getSeconds())

    # 发送用户上线信号
    socket.emit 'online', token: from
    socket.on 'online', (data) ->
      #显示系统消息
      $('.chat .feed').append """
        <div class="event">
          <div class="label">
            <i class="circular inverted blue info icon"></i>
          </div>
          <div class="content">
            <div class="summary">#{"SYSTEM INFORMATION"}
              <div class="date">#{now()}</div>
            </div>
            <div class="extra text">
              #{data.user.name}
            </div>
          </div>
        </div>"""
      #刷新用户在线列表
      flushUsers data.users

    socket.on 'say', (data) ->
      #对所有人说
      if data.to == 'all'
        $('#contents').append '<div>' + data.from + '(' + now() + ')对 所有人 说：<br/>' + data.msg + '</div><br />'
      #对你密语
      if data.to == from
        $('#contents').append '<div style="color:#00f" >' + data.from + '(' + now() + ')对 你 说：<br/>' + data.msg + '</div><br />'

    socket.on 'offline', (data) ->
      #显示系统消息
      sys = '<div style="color:#f00">系统(' + now() + '):' + '用户 ' + data.user + ' 下线了！</div>'
      $('#contents').append sys + '<br/>'
      #刷新用户在线列表
      flushUsers data.users
      #如果正对某人聊天，该人却下线了
      if data.user == to
        to = 'all'
      #显示正在对谁说话
      showSayTo()

    #服务器关闭
    socket.on 'disconnect', ->
      sys = '<div style="color:#f00">系统:连接服务器失败！</div>'
      $('#contents').append sys + '<br/>'
      $('#list').empty()

    #重新启动服务器
    socket.on 'reconnect', ->
      sys = '<div style="color:#f00">系统:重新连接服务器！</div>'
      $('#contents').append sys + '<br/>'
      socket.emit 'online', user: from

    #发话
    $('#send').click ->
      #获取要发送的信息
      message = $('#send_text').val()
      if message is ''
        return
      #把发送的信息先添加到自己的浏览器 DOM 中
      if to == 'all'
        $ '.chat .feed'
        .append """
          <div class="event">
            <div class="label">
              <i class="circular inverted blue user icon"></i>
            </div>
            <div class="content">
              <div class="summary">I to all
                <div class="date">#{now()}</div>
              </div>
              <div class="extra text">#{message}</div>
            </div>
          </div>"""
      else
        $ '.chat .feed'
        .append """
          <div class="event">
            <div class="label">
              <i class="circular inverted blue user icon"></i>
            </div>
            <div class="content">
              <div class="summary">not to all
                <div class="date">#{now()}</div>
              </div>
              <div class="extra text">#{message}</div>
            </div>
          </div>"""
      #发送发话信息
      socket.emit 'say',
        from: from
        to: to
        msg: message
      #清空输入框并获得焦点
      $('#send_text').val('').focus()
