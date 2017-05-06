class Knowledge < ActiveRecord::Base

  include RedisSetter

  attr_accessor :tag_name
  after_save :set_search, :set_redis
  after_update :update_search, :set_redis
  after_destroy :delete_search, :delete_redis

  belongs_to :user, class_name: 'User', optional: true
  belongs_to :category, class_name: 'Category', optional: true

  def set_search
    repository = Elasticsearch::Persistence::Repository.new
    str = content.gsub(/<\/?.*?>/, '')
    bb = KnowledgeSearch.new(id: id, title: title, tag_name: tag_name, content: str, category: category.name, author: author, updated_at: updated_at )
    repository.save(bb)
  end

  def update_search
    repository = Elasticsearch::Persistence::Repository.new
    str = content.gsub(/<\/?.*?>/, '')
    bb = KnowledgeSearch.new(id: id, title: title, tag_name: tag_name, content: str, category: category.name, author: author, updated_at: updated_at )
    repository.update(bb)
  end

  def delete_search
    repository = Elasticsearch::Persistence::Repository.new
    str = content.gsub(/<\/?.*?>/, '')
    bb = KnowledgeSearch.new(id: id, title: title, tag_name: tag_name, content: str, category: category.name, author: author, updated_at: updated_at )
    repository.delete(bb)
  end

  def set_redis
    update_ks self.attributes
  end

  def delete_redis
    destroy_ks id
  end
end
