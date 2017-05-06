$client = Elasticsearch::Client.new url: Settings.elasticsearch[:url], log: true
