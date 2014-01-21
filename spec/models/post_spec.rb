require 'spec_helper'

describe Post do
  describe "#with_all_comment_titles" do
    context "two posts, one matching" do

      it "finds the matching post given two comment titls" do
        p1 = Post.create title: "first post"
        p2 = Post.create title: "second post"

        c1 = p1.comments.create(title: "foo")
        c2 = p1.comments.create(title: "bar")

        c3 = p2.comments.create(title: "foo")

        posts = Post.with_all_comment_titles("bar","foo")

        posts.first.should eql(p1)
        posts.count.should eql(1)

        posts = Post.with_all_comment_titles("foo","bar")

        posts.first.should eql(p1)
        posts.count.should eql(1)
      end
    end
    

    context "sevral posts, two matching" do

      it "finds the matching posts given two comment titls" do
        p1 = Post.create title: "first post"
        p2 = Post.create title: "second post"
        p3 = Post.create title: "second post"

        c1 = p1.comments.create(title: "foo")
        c2 = p1.comments.create(title: "bar")
        c3 = p1.comments.create(title: "baz")
        c4 = p1.comments.create(title: "yollo")

        c5 = p2.comments.create(title: "foo")
        c6 = p2.comments.create(title: "yollo")
        c7 = p2.comments.create(title: "yollo")

        c8 = p3.comments.create(title: "foo")
        c9 = p3.comments.create(title: "bar")

        posts = Post.with_all_comment_titles("foo","yollo")

        posts.first.should eql(p1)
        posts.last.should eql(p2)
        posts.count.should eql(2)

        posts = Post.with_all_comment_titles("yollo","foo")

        posts.first.should eql(p1)
        posts.last.should eql(p2)
        posts.count.should eql(2)
      end
    end

  end


  describe "#map_and_reduce_by_comment_conditions" do 

    it "finds posts that have comments with both titles" do

      p1 = Post.create title: "first post"
      p2 = Post.create title: "second post"

      c1 = p1.comments.create(title: "foo")
      c2 = p1.comments.create(title: "bar")
      c3 = p2.comments.create(title: "foo")

      c4 = p2.comments.create(title: "foo")
      c5 = p2.comments.create(title: "baz")


      posts = Post.map_and_reduce_by_comment_conditions({title: ["foo","bar"]})

      puts posts.to_sql

      posts.first.should eql(p1)
      posts.count.should eql(1)
    end
  end




end
