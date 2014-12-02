require 'test_helper'

class ListingGenresTest < ActionDispatch::IntegrationTest
  test 'lists genres' do
    get '/genres'
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    # debugger
    # assert_equal 2, json(response.body)[:genres].size
  end
end
