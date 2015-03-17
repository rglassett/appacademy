require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
  ).to_s
  
  puts RestClient.post(
    url,
    {user: { email: "gizmo@gizmo.gizmo" } }
  )
end

def show_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1',
  ).to_s
  
  puts RestClient.get(url)
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1',
  ).to_s
  
  puts RestClient.put(url, {user: { name: "Jack"}})
end

def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1',
  ).to_s
  
  puts RestClient.delete(url)
end
show_user

# # bin/my_script.rb
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.html',
#   # query_values: {
#   #     'some_category[a_key]' => 'another value',
#   #     'some_category[a_second_key]' => 'yet another value',
#   #     'some_category[inner_inner_hash][key]' => 'value',
#   #     'something_else' => 'aaahhhhh'
#   #   }
#   ).to_s
#
# puts RestClient.get(url)