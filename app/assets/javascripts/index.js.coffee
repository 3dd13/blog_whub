$ ->

      #------------------------------------------------------------------------#
  #FUNCTIONS
  #DISPLAY ALL USERS

  showUsers = () ->
    $.ajax '/api/users',
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        #Compile the template to a JS function
        template = Handlebars.templates.users
        #Call the template function and pass in the data to return the html
        output = template(data)
        #Insert that html into the template
        $('#content-users').html(output)

  #DISPLAY A USER 
  showUser = (id) ->
    $.ajax "/api/users/#{id}",
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#user-template').html()
        template = Handlebars.compile(source)
        output = template(data.users[0])
        $('#content-users').html(output)

  #DISPLAY ALL ARTICLES
  showArticles = () ->
    $.ajax '/api/articles',
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#articles-template').html()
        template = Handlebars.compile(source)
        output = template(data)
        $('#content-articles').html(output)

  #DISPLAY AN ARTICLE 
  showArticle = (id) ->
    console.log(id)
    $.ajax "/api/articles/#{id}",
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#article-template').html()
        template = Handlebars.compile(source)
        output = template(data.articles[0])
        $('#content-articles').html(output)

  #FROM TAGS - DISPLAY ARTICLES BY SELECTED TAG
  ShowTagArticles = (id) ->
    $.ajax "/api/tags/#{id}",
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#tag-articles-template').html()
        template = Handlebars.compile(source)
        output = template(data.tags[0])
        $('#content-articles').html(output)

  #DISPLAY ALL TAGS
  showTags = () ->
    $.ajax '/api/tags',
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#tags-template').html()
        template = Handlebars.compile(source)
        output = template(data)
        $('#content-tags').html(output)

  #DISPLAY A TAG
  showTag = (id) ->
    console.log(id)
    $.ajax "/api/tags/#{id}",
      type: 'GET',
      dataType: 'json',
      success: (data) ->
        source = $('#tag-template').html()
        template = Handlebars.compile(source)
        output = template(data.tags[0])
        $('#content-tags').html(output)

        #------------------------------------------------------------------------#
  
  showUsers()
  showArticles()
  showTags()

  #FROM USERS - DISPLAY A USER 
  $('section').on 'click', 'ul .users', (e) ->
    id = $(@).data('user-id')
    console.log "HI"
    showUser(id)

  #FROM USER - BACK TO USERS
  $('section').on 'click', '#back-to-users', (e) ->
    showUsers()


  #FROM ARTICLES - DISPLAY AN ARTICLE 
  $('section').on 'click', '.articles', (e) ->
    console.log "clicked on #{$(@).data('article-id')}"
    console.log "display an article"
    id = $(@).data('article-id')
    showArticle(id)
    

  #FROM ARTICLE - BACK TO ARTICLES
  $('section').on 'click', '#back-to-articles', (e) ->
    showArticles()

  #FROM TAGS - DISPLAY A TAG / ARTICLES 
  $('section').on 'click', 'ul .tags', (e) ->
    console.log "display a tag"
    id = $(@).data('tag-id')
    console.log id
    showTag(id)
    ShowTagArticles(id)

  #FROM TAG - BACK TO TAGS
  $('section').on 'click', '#back-to-tags', (e) ->
    showTags()
    showArticles()

  #CREATE AN ARTICLE
  $('#submit-article').on 'click',  ->
    title = $('input#title').val()
    console.log title
    body = $('textarea#body').val()
    console.log body
    author = $('input#author').val()
    console.log author
    $.ajax "/api/articles",
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({article: {title: title, body: body, author: author, is_published: false, tags_attributes: [{ badge: "badge test"}]}}),
      success: (x) ->
        console.log x
    showArticles()

  #DELETE AN ARTICLE

  $('#content-articles').on 'click', '.article-form-opener', (e) ->
    id = $(@).parent().data('article-id')
    $('#deleteArticleModal').modal('show')
    console.log "Setting ID to #{id}"
    $('#delete-article').attr('data-delete-article-id', id)


  $('#delete-article').on 'click',  ->
    id = $(@).data('delete-article-id')
    console.log "hello"
    console.log "#{id}"
    console.log id
    $.ajax "/api/articles/#{id}",
      type: 'DELETE',
      success: (data) ->
        console.log data
    showArticles()

  #UPDATE AN ARTICLE
  $('#update-article').on 'click',  ->
    title = $('input #title').val
    $.ajax "/api/articles/#{id}",
      type: 'PATCH',
      contentType: 'application/json',
      data: JSON.stringify({article: {title: title, body: "body test", author: "author test", is_published: false, tags_attributes: [{ badge: "badge test"}]}}),
      success: (x) ->
        console.log x

        #------------------------------------------------------------------------#

  #ON CLICK LIGHT
  $('#light').on 'click',  ->
    console.log "light"
    $(@).toggleClass light dark, (currentclass), true
      

      
        



