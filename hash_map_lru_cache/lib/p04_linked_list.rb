class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
include Enumerable

  attr_accessor :head, :tail
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil if empty?

    next_link = first
    until next_link.key == key || next_link.key.nil?
      next_link = next_link.next
    end

    next_link.val
  end

  def get_link(key)
    return nil if empty?

    next_link = first
    until next_link.nil? || next_link.key == key
      next_link = next_link.next
    end

    next_link
  end

  def include?(key)
    get(key).nil? ? false : true
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if empty?
      new_link.prev, new_link.next = @head, @tail
      @head.next = new_link
      @tail.prev = new_link
    else
      new_link.prev, new_link.next = last, @tail
      last.next = new_link
      @tail.prev = new_link
    end
  end

  def update(key, val)
    old_link = get_link(key)
    old_link.val = val unless old_link.nil?
  end

  def remove(key)
    old_link = get_link(key)
    old_link.remove
  end

  def each
    result = []
    next_link = first
    until next_link == @tail
      result << yield(next_link)
      next_link = next_link.next
    end
    result
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
