class Comment < ActiveRecord::Base
  belongs_to :post

  def self.with_title(title)
    where(title: title)
  end
end
