require 'test_helper'

  class CreateArticleTest < ActionDispatch::IntegrationTest
    def setup
      @user = User.create(username:"john", email:"john@example.com", password:"password")
    end

    test "create new article as logged user" do
      sign_in_as(@user, "password")
      get new_article_path
      assert_template 'articles/new'
      assert_difference "Article.count", 1 do
        post articles_path, params: {article: {title: "Test title", description: "This is test description"}}
        follow_redirect!
      end
      assert_template 'articles/show'
      assert_select 'h2', text: "Test title"
    end

  end
