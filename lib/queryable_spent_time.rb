module QueryableSpentTime
  extend ActiveSupport::Concern

  included do
    alias_method_chain :initialize_available_filters, :spent_hours
  end

  def initialize_available_filters_with_spent_hours
    initialize_available_filters_without_spent_hours
    add_available_filter "spent_hours", :type => :float
  end

  def sql_for_spent_hours_field(field, operator, value)
    query = "(SELECT SUM(hours) FROM #{TimeEntry.table_name} WHERE #{TimeEntry.table_name}.issue_id = #{Issue.table_name}.id)"
    sql = case operator
      when "><"
        "BETWEEN #{value[0].to_f} AND #{value[1].to_f}"
      when "!*"
        "IS NULL"
      when '*'
        "IS NOT NULL"
      else
        "#{operator} #{value[0].to_f}"
    end
    [query, sql].join(' ')
  end
end