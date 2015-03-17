class Reply
  
  include QueryHelperModule
  
  attr_accessor :id, :body, :question_id, :parent_id, :author_id
  
  def initialize(options={})
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
  end
  
  def self.find_by_user_id(author_id)
    self.find_by_column('author_id', author_id)
  end
  
  def self.find_by_question_id(question_id)
    self.find_by_column('question_id', question_id)
  end
  
  def author
    User.find_by_id(author_id)
  end
  
  def question
    Question.find_by_id(question_id)
  end
  
  def parent_reply 
    Reply.find_by_id(parent_id)
  end
  
  def child_replies
    self.find_by_column('parent_id', id )
  end
end