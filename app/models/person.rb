class Person < ApplicationRecord

  def speak
    puts "Hello world!"
    "something"
  end

  def listen
    s = Something.new(10)
    puts "We finish at #{s.report}"
    return 1 + 1
  end
end
