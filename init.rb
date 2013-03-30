require 'queryable_spent_time'

Redmine::Plugin.register :redmine_queryable_spent_time do
  name 'Redmine Queryable Spent Time plugin'
  author 'Altoros Systems, Inc. <pavel.pachkovskij@altoros.com>'
  description 'This plugin allows to filter issues by Spent Time column.'
  version '0.1.0'
  url 'https://github.com/pavelpachkovskij/redmine_queryable_spent_time'
  author_url 'https://github.com/pavelpachkovskij/redmine_queryable_spent_time'
end

Rails.configuration.to_prepare do
  require_dependency 'issue_query'
  IssueQuery.send(:include, QueryableSpentTime)
end