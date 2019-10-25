class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def self.all
    @@all
  end

  def initialize(student_hash)
    student_hash.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    self.class.all << self
  end

  def self.create_from_collection(students_array)
        students_array.each{|e|
          Student.new(e)
        }
  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def self.all
    @@all
  end
end

