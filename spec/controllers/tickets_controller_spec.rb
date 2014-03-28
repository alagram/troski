require 'spec_helper'

describe TicketsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(user)
      get :show, id: ticket.id, project_id: project.id

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("The project you were looking for could not be found.")
    end

    context "with permission to view the project" do

      before do
        sign_in(user)
        define_permission!(user, "view", project)
      end

      def cannot_create_tickets!
        expect(response).to redirect_to(project)
        message = "You cannot create tickets on this project."
        expect(flash[:alert]).to eq(message)
      end

      it "cannot begin to create a ticket" do
        get :new, project_id: project.id
        cannot_create_tickets!
      end
    end
  end
end
