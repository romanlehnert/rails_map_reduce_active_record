class Post < ActiveRecord::Base

  has_many :comments


  # simple example to reduce by multiple titles
  def self.with_all_comment_titles(*titles)
    titles.map { |title|
      Post.joins(:comments).where(comments: {title: title}).select(:post_id)                   
    }.reduce(all) { |scope, subquery|
      scope.where(id: subquery)
    }
  end


  def self.map_and_reduce_by_comment_conditions(conditions)
    conditions.reduce([]) { 
      |memo,(key,values)| values.map{ |value| [key, value]} 
    }.map { |condition|
      joins(:comments).where(comments: {condition.first.to_sym => condition.last}).select(:post_id)
    }.reduce(all) { |scope, subquery|
      scope.where(id: subquery)
    }
  end

end
