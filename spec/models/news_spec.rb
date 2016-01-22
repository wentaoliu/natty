require 'rails_helper'

describe News do

  it "should not save news article without title" do
    article = News.new do |a|
      a.content = "Hello\nworld!"
    end
    expect(article.save).to eq false
  end

  it "should not save news article without content" do
    article = News.new do |a|
      a.title = 'Test'
    end
    expect(article.save).to eq false
  end

end
