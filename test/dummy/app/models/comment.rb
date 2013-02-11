class Comment < ActiveRecord::Base
  attr_accessible :post, :content
  belongs_to :post
end
