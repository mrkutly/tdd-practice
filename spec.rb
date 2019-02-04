# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    if @middle_name
      "#{@first_name} #{@middle_name} #{@last_name}"
    else
      "#{@first_name} #{@last_name}"
    end
  end

  def full_name_with_middle_initial
    if @middle_name
      "#{@first_name} #{initial(@middle_name)} #{@last_name}"
    else
      "#{@first_name} #{@last_name}"
    end
  end

  def initials
    if @middle_name
      initial(@first_name) + initial(@middle_name) + initial(@last_name)
    else
      initial(@first_name) + initial(@last_name)
    end
  end

  def initial(name)
    name[0] + "."
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      mark = Person.new(first_name: 'mark', middle_name: 'robert', last_name: 'sauer-utley')

      expect(mark.full_name).to eq('mark robert sauer-utley')
    end

    it "does not add extra spaces if middle name is missing" do
      mark = Person.new(first_name: 'mark', last_name: 'sauer-utley')

      expect(mark.full_name).to eq('mark sauer-utley')
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first name, middle initial, and last name with spaces" do
      mark = Person.new(first_name: 'mark', middle_name: 'robert', last_name: 'sauer-utley')

      expect(mark.full_name_with_middle_initial).to eq('mark r. sauer-utley')
    end

    it "does not fail or add extra spaces if middle name is missing" do
      mark = Person.new(first_name: 'mark', last_name: 'sauer-utley')

      expect(mark.full_name_with_middle_initial).to eq('mark sauer-utley')
    end
  end

  describe "#initials" do
    it "concatenates first initial, middle initial, and last initial with spaces" do
      mark = Person.new(first_name: 'mark', middle_name: 'robert', last_name: 'sauer-utley')

      expect(mark.initials).to eq('m.r.s.')
    end

    it "does not fail or add extra spaces if middle name is missing" do
      mark = Person.new(first_name: 'mark', last_name: 'sauer-utley')

      expect(mark.initials).to eq('m.s.')
    end
  end
end
