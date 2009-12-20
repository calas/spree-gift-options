module GiftOptions
  class Config
    include Singleton
    include PreferenceAccess

    class << self
      def instance
        return @configuration if @configuration
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        @configuration ||= GiftConfiguration.find_or_create_by_name("Gift Options configuration")
        @configuration
      end
    end
  end
end
