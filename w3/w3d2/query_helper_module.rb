require 'active_support/inflector'

module QueryHelperModule
  module ClassMethods
    def table_name
      self.to_s.pluralize.underscore
    end
    
    def find_by_column(column_name, column_value)
      results = QuestionsDatabase.instance.execute(<<-SQL, column_value)
        SELECT
          *
        FROM
          #{table_name}
        WHERE
          #{column_name} = ?
      SQL
      results.map { |result| self.new(result) }
    end
    
    def find_by_id(id)
      find_by_column('id', id).first
    end
  end
  
  def self.included base
    base.extend(ClassMethods)
  end

  def save
    var_names = self.instance_variables.map { |v| v.to_s.gsub('@', '') }
    var_vals = var_names.map { |var| self.instance_variable_get("@#{var}") }
    
    if id.nil?
      execute_save(var_vals, var_names)
    else
      execute_update(var_vals, var_names)
    end
  end
  
  def execute_save(var_vals, var_names)
    question_marks = "(#{var_vals.drop(1).map { "?" }.join(", ")})"
    
    QuestionsDatabase.instance.execute(<<-SQL, *var_vals.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{var_names.drop(1).join(", ")})
    VALUES
      #{question_marks}
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
  
  def execute_update(var_vals, var_names)
    update_string = var_names.drop(1).map { |var| "#{var} = ?" }.join(", ")
    
    QuestionsDatabase.instance.execute(<<-SQL, *var_vals.drop(1))
    UPDATE
      #{self.class.table_name}
    SET
      #{update_string}
    WHERE
      id = #{@id}
    SQL
  end
end