require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, name: "Trotromate") }

  let(:ticket) do
    ticket = project.tickets.build(title: "State transitions", description: "Can't be hacked.")
    ticket.user = user
    ticket.save
    ticket
  end

  let(:state) { FactoryGirl.create(:state, name: "New") }

  context "a user without permission to set state" do
    before do
      sign_in(user)
    end

    it "cannot transition a state by passing through the state_id" do
      post :create, comment: { text: "Hacked", state_id: state.id }, ticket_id: ticket.id
      ticket.reload
      expect(ticket.state).to eq(nil)
    end
  end
end
