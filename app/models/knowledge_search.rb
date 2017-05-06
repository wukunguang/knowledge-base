class KnowledgeSearch
  attr_reader :attributes
  def initialize(attributes={})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end

  def build_dsl(keywords, size = 0, from = 0)

    ss = {
        query: {
            bool: {
                should: [
                ]
            }
        }
    }

    keywords.split(' ').each do |k|
      ss[:query][:bool][:should].push(build_sigle_dsl(k))
    end

    if size > 0
      ss.store('size', size)
      ss.store('from', from)
    end
    ss
  end

  def build_sigle_dsl(keyword)
    {
        bool: {
            should: [
                {
                    match_phrase_prefix: {
                        title: {
                            query: keyword,
                            boost: 5
                        }
                    }
                },
                {
                    match_phrase_prefix: {
                        tag_name: {
                            query: keyword,
                            boost: 3
                        }
                    }
                },
                {
                    match_phrase_prefix: {
                        content: {
                            query: keyword,
                            max_expansions: 50

                        }
                    }
                }
            ]
        }
    }
  end

end