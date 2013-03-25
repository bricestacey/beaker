require 'spec_helper'

describe UsersController do
  describe "#new" do
    it "shows the signup form" do
      get :new
      assigns[:user].should be_new_record
      response.should render_template('new')
    end
  end

  describe "#create" do
    context 'with invalid data' do
      let(:user_params) { FactoryGirl.attributes_for(:user).slice(:email) }

      it 'renders the new form' do
        post :create, user: user_params
        response.should render_template('new')
      end
    end

    context 'with valid data' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it "creates and authenticates the user" do
        controller.should_receive(:sign_in)
        post :create, user: user_params
        response.should be_redirect
      end
    end
  end
end
