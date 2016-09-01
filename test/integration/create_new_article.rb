require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
    @article = Article.create(title: "Create new article test", description: "Create new article test description")
  end
  
  test "Create a new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Create new article test", description: "Create new article test description"}
    end
    assert_template 'articles/show'
    assert_match @article.description, response.body
  end
  
  test "Ensure article title and article description not blank" do
    @article.title = " "
    assert_not @article.valid?
    @article.description = " "
    assert_not @article.valid?
  end
end