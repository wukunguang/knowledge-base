
class KnowledgeRepository
  include Elasticsearch::Persistence::Repository
  # Configure the Elasticsearch client
  client $client
  # Set a custom index name
  index :knowledge

  # Set a custom document type
  type  :knowledge

  # Specify the class to initialize when deserializing documents
  klass KnowledgeSearch

  # Configure the settings and mappings for the Elasticsearch index
  settings number_of_shards: 1 do
    mapping do
      indexes :text, analyzer: 'mmseg_maxword'
      indexes :created_at, type: 'date'
      indexes :updated_at, type: 'date'
    end
  end

  # Customize the serialization logic
  def serialize(document)

    super.merge(my_special_key: 'my_special_stuff')
  end

  # Customize the de-serialization logic
  def deserialize(document)
    KnowledgeSearch.new document['_source'].merge('ks_id' => document['id'])
  end
end