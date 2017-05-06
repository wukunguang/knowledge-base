
module RedisSetter

  KS_HEADER = 'ks'
  KS_SORT = 'sort'
  KS_KEYWORD = 'kw'

  def update_ks(knowledge)
    hash = {}
    short_ks = {}
    $redis.get(KS_HEADER) ? hash = JSON.parse($redis.get(KS_HEADER)) : hash = {}
    key = KS_HEADER + knowledge['id'].to_s
    if !hash[key]
      short_ks = {
          title: knowledge['title'],
          id: knowledge['id'],
          author: knowledge['author'],
          update_at: knowledge['updated_at'].to_s,
          get_count: 0
      }
    else
      short_ks = hash[key]
      short_ks['title'] = knowledge['title']
      short_ks['author'] = knowledge['author']
      short_ks['update_at'] = Time.now.to_s
    end
    hash.store(KS_HEADER + knowledge['id'].to_s, short_ks)
    save_to_db hash
  end

  def update_get_count(id)
    id = id.to_s
    hash = JSON.parse($redis.get(KS_HEADER))
    key = KS_HEADER + id
    short_ks = hash[key]
    short_ks['get_count'] += 1
    hash.store(KS_HEADER + id, short_ks)
    save_to_db hash
  end

  def destroy_ks(id)
    id = id.to_s
    hash = JSON.parse($redis.get(KS_HEADER))
    key = KS_HEADER + id
    hash.delete(key)
    save_to_db hash
  end

  def sort_by_count
    cache = $redis.get(KS_HEADER)
    if cache
      hash = JSON.parse(cache)
      return hash.sort_by { |k, v| v['get_count'] }.last(10)
    else
      return []
    end
  end

  def sort_by_update
    cache = $redis.get(KS_HEADER)
    if cache
      hash = JSON.parse(cache)
      return hash.sort_by { |k, v| v['updated_at'] }.last(5)
    else
      return []
    end
  end

  def get_keyword_rk
    cache = $redis.get(KS_KEYWORD)
    if cache
      hash = JSON.parse(cache)
      return hash.sort_by { |k, v| v['count'] }.last(5)
    else
      return []
    end
  end

  def set_keywords(keywords)
    $redis.get(KS_KEYWORD) ? hash = JSON.parse($redis.get(KS_KEYWORD)) : hash = {}
    kw_arr = keywords.split(' ')
    kw_arr.each do |p, el|
      if hash.has?(el)
        count = hash[:el] + 1
        hash.store(el, count)
      else
        hash.store(el, 1)
      end
    end
    save_to_db(hash, KS_KEYWORD)
  end

  #定时任务，把缓存写进硬盘
  def self.save_disk
    $redis.save
  end

  private

  def save_to_db(hash, key = KS_HEADER)
    $redis.set(key, hash.to_json)
  end


end