require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'creates new books with valid data' do
    post '/books', { book: { 
      title: 'A title',
      rating: 5,
      author: 'Dave Thomas',
      genre_id: 1,
      review: 'Excellent book for any programmer.',
      amazon_id: '13123'
      } }.to_json, 
      { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    result = json(response.body)[:book]
    assert_equal book_url(result[:id]), response.location
    assert_equal 'A title', result[:title]
    assert_equal 5, result[:rating]
    assert_equal 'Dave Thomas', result[:author]
    assert_equal 1, result[:genre_id]
    assert_equal 'Excellent book for any programmer.', result[:review]
    assert_equal '13123', result[:amazon_id]
    assert Book.find(result[:id])
  end

  test 'does not create books with invalid data' do
    post '/books', { book: {
      title: nil ,
      rating: 5 } }.to_json, 
      { 'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_match /(?=.*title)(?=.*can't be blank).*/, json(response.body).to_s
  end
end
