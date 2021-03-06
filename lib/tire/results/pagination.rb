module Tire
  module Results

    # Adds support for WillPaginate and Kaminari
    #
    module Pagination

      def total_entries
        @total
      end

      def per_page
        (@options[:per_page] || @options[:size] || 10 ).to_i
      end

      def total_pages
        ( @total.to_f / per_page ).ceil
      end

      def current_page
        if @options[:page]
          @options[:page].to_i
        else
          from = @options[:from].to_i || 0
          (per_page + from) / per_page
        end
      end

      def previous_page
        current_page > 1 ? (current_page - 1) : nil
      end

      def next_page
        current_page < total_pages ? (current_page + 1) : nil
      end

      def offset
        per_page * (current_page - 1)
      end

      def out_of_bounds?
        current_page > total_pages
      end

      # Kaminari support
      #
      alias :limit_value  :per_page
      alias :total_count  :total_entries
      alias :num_pages    :total_pages
      alias :offset_value :offset

    end

  end
end
