class User < ActiveRecord::Base

  # Return a set of records matching the given +filters+.
  #
  # ==== Options
  # +filters+ Hash of filters that are parsed to build SQL conditions.
  #
  # ==== Examples
  # To find all users with Joe in their name
  #   User.search :all, :filters => { :terms => %w(joe) }
  #
  # To find the first user with the terms "Fred" and "Smith" in their name
  #   User.search :first, :filters => { :terms => %w(Fred Smith) }
  #
  # To find only admin users
  #   User.search :all, :filters => { :admin => true }
  def self.search(*args)
    options = args.extract_options!

    # Extract filters from the options, or default to empty
    filters = options.delete(:filters) || {}
  
    # Create an empty condition clause, into which we can append filters
    combined_conditions = Caboose::EZ::Condition.new :users

    # Use filter terms to search by first_name OR last_name
    unless filters[:terms].nil?
      filters[:terms].each do |term|
        term = ['%', term, '%'].join

        condition = Caboose::EZ::Condition.new :users do
          
        end
        
        condition.append ['first_name LIKE ?', term], :or
        condition.append ['last_name LIKE ?', term], :or
        condition.append ['email_address LIKE ?', term], :or
 
        combined_conditions << condition
      end
    end

    # Apply the :admin filter
    unless filters[:admin].nil?
      condition = Caboose::EZ::Condition.new :users do 
        admin == filters[:admin]
      end

      combined_conditions << condition
    end

    # Apply the :status filter
    unless filters[:status].nil?
      condition = Caboose::EZ::Condition.new :users do
        status === [*filters[:status]] # use [*obj] rather than obj.to_a as Object.to_a is depracated
      end

      combined_conditions << condition
    end

    # Convert the combined set of filter conditions to a SQL fragment, and store in the options hash for User.find
    options[:conditions] = combined_conditions.to_sql

    self.find(args.first, options)
  end
end
