require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki) }
  let(:user) { my_wiki.user }

  describe "guest user" do

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns authentication error" do
        # byebug
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "logged in user" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        # byebug
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #create" do
      it "returns http redirect" do
        get :create, wiki: { title: 'foo' }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET #update" do
      it "returns http redirect" do
        get :update, id: my_wiki.id, wiki: { title: 'foo' }
        expect(response).to have_http_status(:redirect)
      end
      it "updates the attributes" do
        get :update, id: my_wiki.id, wiki: { title: 'foo' }
        # my_wiki.reload
        wiki = Wiki.find my_wiki.id
        expect(wiki.title).to eql 'foo'
      end
    end

    describe "GET #destroy" do
      it "returns http redirect" do
        get :destroy, id: my_wiki.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
