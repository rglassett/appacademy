class Question
  
  include QueryHelperModule
  
  attr_accessor :id, :title, :body, :author_id
  
  def initialize(options={})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
  
  def self.find_by_author_id(author_id)
    self.find_by_column('author_id',author_id)
  end
  
  def author
    User.find_by_id(author_id)
  end
  
  def replies 
    Reply.find_by_question_id(id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(id)
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def likers
    QuestionLike.likers_for_question_id(id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end