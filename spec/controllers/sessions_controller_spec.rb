require 'rails_helper'

describe SessionsController do
  include SessionsHelper

  describe "POST create" do
    let(:client) {create(:user)}
    context 'when a user is a client' do
      it 'renders the client home' do
        post :create, {params: {session: {email: client.email, password: client.password}}}
        expect(response).to redirect_to(user_home_path)
      end
    end

    context 'when user is a chef' do
      let(:chef_user) {create(:user, role: :chef, email: 'chef@chef.com')}
      let(:chef) {create(:chef, user_id: chef_user.id)}
      it 'redirects to chef home page' do
        post :create, {params: {session: {email: chef_user.email, password: chef_user.password}}}
        expect(response).to redirect_to(user_chefs_path(chef_user.id))
      end
    end
  end

  describe "GET new" do
    context 'when user is logged out' do
      it 'renders the new template' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context 'when user is logged in' do
      let(:client) {create(:user)}
      it 'redirects to user home' do
        log_in(client)
        get :new
        expect(response).to redirect_to(user_home_path)
      end
    end
  end

  describe "DELETE destroy" do
    it 'redirects to root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      let(:client) {create(:user)}
      before do
        log_in(client)
        delete :destroy
      end
      it 'deletes the user\'s session' do
        expect(session[:user_id]).to be_nil
      end

    end

  end
end