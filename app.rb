require 'sinatra'

get('/')          { haml :index }
get('/style.css') { sass :style }
get('/app.js')    { coffee :app }
