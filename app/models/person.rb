class Person < ApplicationRecord
  belongs_to :user

  def speak
    puts "Hello world!"
    "something"
  end

  def listen
    # s = Something.new(10)
    # puts "We finish at #{s.report}"
    return 1 + 1
  end

  def private_name
    self.given_name.presence || "Friend"
  end

  def public_name
    self.display_name.presence || "Anonymous"
  end

  def has_social?
    [self.li_name, self.ig_name, self.fb_name, self.tw_name].any?(&:present?)
  end
end
