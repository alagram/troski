require './test/test_helper'

class CreatingTicketsTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryGirl.create(:user)
  end

  test 'creates tickets' do
    post "/api/tickets",
      { ticket:
        { title: 'My first ticket', description: 'Here I am testing APIs at last! This is good progress.',
          user_id: "#{@user.id}" }
      }.to_json,
      { 'Authorization' => "Token token=#{@user.token}", 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      assert_equal 201, response.status
      assert_equal Mime::JSON, response.content_type

      ticket = json(response.body)
      assert_equal ticket_url(ticket[:id]), response.location
  end
end
