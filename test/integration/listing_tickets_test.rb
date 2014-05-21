require './test/test_helper'

class ListingTicketsTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryGirl.create(:user)
  end

  test "returns list of all tickets" do
    get 'api/tickets', {}, { 'Authorization' => "Token token=#{@user.token}" }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    refute_empty response.body
  end

  test "returns tickets by id" do
    ticket = FactoryGirl.create(:ticket)
    get "api/tickets/#{ticket.id}", {}, { 'Authorization' => "Token token=#{@user.token}" }
    assert_equal 200, response.status

    ticket_response = json(response.body)
    assert_equal ticket.title, ticket_response[:title]
  end
end
