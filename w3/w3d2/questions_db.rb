require "singleton"
require 'sqlite3'
require_relative 'query_helper_module'
require_relative 'user'
require_relative 'question'
require_relative 'question_like'
require_relative 'question_follower'
require_relative 'reply'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end








